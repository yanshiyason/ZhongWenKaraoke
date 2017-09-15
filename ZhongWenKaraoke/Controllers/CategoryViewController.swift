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

class CategoryViewController: UIViewController {
    var songs: [MiguSong]?
    var category: MiguCategory!
    
    @IBOutlet weak var songsTable: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "\(category.chinese) / \(category.english)"

        setNowPlayingLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavbarColor()
        // Do any additional setup after loading the view.
//        songsTable.delegate = self
//        songsTable.dataSource = self
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
        MiguSongStore.songs.asObservable()
            .bind(to: songsTable.rx.items(cellIdentifier: "MiguSongCell", cellType: MiguSongCell.self)) {row, song, cell in
                if let sd = song.songDetails,
                    let _ = sd.safeMp3Url {
                    cell.config(withSong: song)
                    cell.backgroundColor = colors[row % colors.count]
                } else {
//                    cell.delete(nil)
                    cell.isHidden = true
                }
            }
            .addDisposableTo(disposeBag)
        
        songsTable.rx
            .setDelegate(self)
            .addDisposableTo(disposeBag)
        
//        songsTable.rx.modelSelected(MiguSong)
//            .subscribe(onNext: {
//                print($0)
//            })
//            .addDisposableTo(disposeBag)
        
//        data.bindTo(tableView.rx_itemsWithCellIdentifier("Cell")) { _, contributor, cell in
//            cell.textLabel?.text = contributor.name
//            cell.detailTextLabel?.text = contributor.gitHubID
//            cell.imageView?.image = contributor.image
//            }
//            .addDisposableTo(disposeBag)
//        
//        tableView.rx_modelSelected(Contributor)
//            .subscribeNext {
//                print("You selected \($0)")
//            }
//            .addDisposableTo(disposeBag)

        MiguSongStore.songs//.asDriver()
            .asObservable()
            .subscribe(onNext: {
                print("inside map")
                print($0.count)
                self.songs = $0
                self.songsTable.reloadData()
            }, onCompleted: {
                print("Completed")
            }, onDisposed: {
                print("Disposed")
            })
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
                AppState.cellBgColor = songsTable.cellForRow(at: songsTable.indexPathForSelectedRow!)?.backgroundColor
            }
        }
        
        if segue.identifier == "ShowNowPlaying" {
            let vc = segue.destination as! MiguSongTabBarController
            let songDetailsVC = vc.childViewControllers[0] as! MiguSongDetailsViewController
            songDetailsVC.song = AppState.currentSong
        }
    }
    
    private func songForSelectedRow() -> MiguSong? {
        if let row = songsTable.indexPathForSelectedRow?.row {
            return songs?[row]
        } else {
            return nil
        }
    }
    
}

extension CategoryViewController: UITableViewDelegate {
}

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MiguSongCell", for: indexPath) as! MiguSongCell
        
        cell.backgroundColor = colors[indexPath.row % colors.count]
        cell.addShadow()
        
        if let song = songs?[indexPath.row] {
            cell.config(withSong: song)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
