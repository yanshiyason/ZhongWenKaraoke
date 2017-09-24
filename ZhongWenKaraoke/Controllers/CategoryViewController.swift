//
//  CategoryViewController.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/21/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CategoryLayout: UICollectionViewFlowLayout {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override init() {
        super.init()
        let padding = CGFloat(10)
        sectionInset = UIEdgeInsets(top: padding, left: 0, bottom: padding, right: 0)
        minimumLineSpacing = padding
        minimumInteritemSpacing = padding
        let itemWidth = screenWidth - (padding * 2)
        let itemHeight = (screenHeight/5) - padding
        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class CategoryViewController: UIViewController {
    var songs: [MiguSong]?
    var category: MiguCategory!

    @IBOutlet weak var songsTable: UICollectionView!

    let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "\(category.chinese) / \(category.english)"

        setNowPlayingLabel()
    }
    
    override func viewWillLayoutSubviews() {
        songsTable.collectionViewLayout = CategoryLayout()
        songsTable.isPrefetchingEnabled = false
        
        // this redraws the shadows
        songsTable.reloadSections(IndexSet(integer: 0))
    }
    
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavbarColor()
        activityIndicator = spawnActivityIndicator()

        songsTable.backgroundColor = .mainColor
        
        MiguSongStore.hasOnGoingRequest
            .asDriver()
            .drive(self.activityIndicator.rx.isAnimating)
            .addDisposableTo(disposeBag)
        
        MiguSongStore.songs.asObservable()
            .map({return $0.filter({return $0.isValid()})})
            .do(onNext: {self.songs = $0})
            .bind(to: songsTable.rx.items(cellIdentifier: "MiguSongCell", cellType: MiguSongCell.self)) {row, song, cell in
                cell.config(withSong: song)
                cell.backgroundColor = colors[row % colors.count]
                cell.cornerRadius = 10.0
                cell.posterImg?.borderRadiusLeftSide(10)
                cell.addShadow()
            }
            .addDisposableTo(disposeBag)
        
        MiguSongStore.songsFor(category: category)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToSongView" {
            if let song = songForSelectedRow() {
                AppState.currentSong = song
                
                // Set the color of the following the same as cell
                AppState.cellBgColor = songsTable.cellForItem(at: songsTable.indexPathsForSelectedItems![0])?.backgroundColor
            }
        }
        
        if segue.identifier == "ShowNowPlaying" {
            let vc = segue.destination as! MiguSongTabBarController
            let songDetailsVC = vc.childViewControllers[0] as! MiguSongDetailsViewController
            songDetailsVC.song = AppState.currentSong
        }
    }
    
    private func songForSelectedRow() -> MiguSong? {
        if let row = songsTable.indexPathsForSelectedItems?[0].row {
            return songs?[row]
        } else {
            return nil
        }
    }
    
}
