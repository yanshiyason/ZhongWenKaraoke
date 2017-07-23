//
//  MiguSongDetailsViewController.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/22/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit

class MiguSongDetailsViewController: UIViewController {
    var song: MiguSong!

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let parentVC = self.tabBarController as! MiguSongTabBarController
        self.song = parentVC.song
        
        fillUIWith(song: song)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func fillUIWith(song: MiguSong) {
        if let poster = song.songDetails?.poster {
            posterImage.setImageFromURl(poster)
        }
        if let title = song.songDetails?.songName {
            songTitle?.text = title.removingPercentEncoding
        }
        if let artist = song.songDetails?.singerName {
            artistName?.text = artist
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
