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

    override func viewDidLoad() {
        super.viewDidLoad()
        let parentVC = self.tabBarController as! MiguSongTabBarController
        self.song = parentVC.song
        
        // Do any additional setup after loading the view.
        lyricsTable.delegate = self
        lyricsTable.dataSource = self
        
        JukeboxService.playbackTime.asDriver()
            .throttle(1)
            .filter({ _ in
                self.lastTouch.timeIntervalSinceNow < -3.0 // more than 3 second should have passed since last touch
            })
            .map({
                self.song.songLyrics!.lineIndex(for: Float($0 ?? 0))
            })
            .map({ $0 == -1 ? 0 : $0 })
            .map({ IndexPath(row: $0, section: 0) })
            .drive(onNext: {
                self.lyricsTable.scrollToRow(at: $0, at: .middle, animated: true)
            })
            .addDisposableTo(disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.lastTouch = Date()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let songLyrics = song.songLyrics {
            return songLyrics.lyrics.count
        } else {
            return 1
        }
    }
}
