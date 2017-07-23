//
//  MiguSongLyricsViewController.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/24/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit

class MiguSongLyricsViewController: UIViewController {
    var song: MiguSong!
    
    @IBOutlet weak var lyricsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let parentVC = self.tabBarController as! MiguSongTabBarController
        self.song = parentVC.song
        
        // Do any additional setup after loading the view.
        lyricsTable.delegate = self
        lyricsTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MiguSongLyricsViewController: UITableViewDelegate {
}

extension MiguSongLyricsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if song.songLyrics == nil {
            return UITableViewCell()
        } else {
            let cell = lyricsTable.dequeueReusableCell(withIdentifier: "LyricLineCell", for: indexPath)
            cell.textLabel?.text = self.song.songLyrics?.lyrics[indexPath.row].text
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
