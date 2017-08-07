//
//  MiguSongLyricsViewController.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/24/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MiguSongLyricsViewController: UIViewController {
    var song: MiguSong!

    @IBOutlet weak var lyricsTable: UITableView!
    
    let disposeBag = DisposeBag()
    var lastTouch = Date()
    var currentyPlayingIndex: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        let parentVC = self.tabBarController as! MiguSongTabBarController
        parentVC.hidesBottomBarWhenPushed = true
        self.navigationController!.hidesBarsOnSwipe = true

        self.song = parentVC.song
        
        // Do any additional setup after loading the view.
        lyricsTable.delegate = self
        lyricsTable.dataSource = self
        
        JukeboxService.playbackTime.asDriver()
            .filter({ _ in
                self.lastTouch.timeIntervalSinceNow < -1.0 // more than 1 second should have passed since last touch
            })
            .do(onNext: { _ in
                if self.tabBarController?.selectedIndex == 1 {
                    self.tabBarController?.tabBar.isHidden = true
                    self.navigationController?.isNavigationBarHidden = true
                }
            })
            .map({
                self.song.songLyrics!.lineIndex(for: Float($0 ?? 0))
            })
            .map({ $0 == -1 ? 0 : $0 })
            .map({ IndexPath(row: $0, section: 0) })
            .distinctUntilChanged()
            .drive(onNext: {
                if $0.row > 0 { self.currentyPlayingIndex = $0 }
                if let previous = self.previousIndexPath($0) {
//                    self.lyricsTable.cellForRow(at: previous)?.backgroundColor = .black
                    self.lyricsTable.deselectRow(at: previous, animated: false)
                }
//                self.lyricsTable.scrollToRow(at: $0, at: .middle, animated: true)
                self.lyricsTable.selectRow(at: $0, animated: true, scrollPosition: .middle)
            })
            .addDisposableTo(disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let i = currentyPlayingIndex else { return }
        self.lyricsTable.selectRow(at: i, animated: true, scrollPosition: .middle)
        view.frame = UIApplication.shared.keyWindow!.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard lyricsTable.isDragging || lyricsTable.isDecelerating else { return } // return unless drag is caused by user
        self.lastTouch = Date()
        showTabBars()
    }
    
    func showTabBars() {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
    }
    
    enum ValidDisplay {
        case none
        case pinyin
        case traditional
    }
    
    var currentlyDisplaying: ValidDisplay = .none

    @IBAction func didTapCycle(_ sender: Any) {
        switch currentlyDisplaying {
        case .none:
            currentlyDisplaying = .pinyin
        case .pinyin:
            currentlyDisplaying = .traditional
        case .traditional:
            currentlyDisplaying = .none
        }
        lyricsTable.reloadData()
    }
}

extension MiguSongLyricsViewController: UITableViewDelegate {
}

extension MiguSongLyricsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if song.songLyrics == nil {
            return UITableViewCell()
        } else {
            let cell = lyricsTable.dequeueReusableCell(withIdentifier: "LyricLineCell", for: indexPath) as! LyricLineCell
            
            cell.simplified?.text = self.song.songLyrics?.lyrics[indexPath.row].text().toSimplified()

            switch currentlyDisplaying {
            case .none:
                cell.tradOrpinyin?.text = ""
            case .pinyin:
                cell.tradOrpinyin?.text = self.song.songLyrics?.lyrics[indexPath.row].text().toPinyin()
            case .traditional:
                cell.tradOrpinyin?.text = self.song.songLyrics?.lyrics[indexPath.row].text().toTraditional()
            }

            return cell
        }
    }
    
    func previousIndexPath(_ indexPath: IndexPath) -> IndexPath? {
        guard indexPath.row > 0 else { return nil }
        return IndexPath(row: indexPath.row - 1, section: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let songLyrics = song.songLyrics {
            return songLyrics.lyrics.count
        } else {
            return 1
        }
    }
}
