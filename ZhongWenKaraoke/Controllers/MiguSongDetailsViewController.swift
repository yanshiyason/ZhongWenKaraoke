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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppState.cellBgColor
        for sv in view.subviews {
            sv.backgroundColor = AppState.cellBgColor
        }
        setNavbarColor()

        if let song = self.song {
            if song == AppState.currentSong && JukeboxService.jukebox.state == .playing {
                print("song already playing")
            } else {
                self.song = AppState.currentSong
                JukeboxService.play()
            }
        } else {
            self.song = AppState.currentSong
            JukeboxService.play()
        }
        
        fillUIWith(song: song)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        // trying to remove the jukebox view
        // and play the music by setting it as a static attribute on the AppState struct
        //
//        if segue.identifier == "SegueToJukebox" {
//            if let parentVC = self.tabBarController as! MiguSongTabBarController? {
//                let jukeboxVC = segue.destination as! JukeboxViewController
//                jukeboxVC.miguSong = parentVC.song
//                JukeboxService.jukeboxVC = jukeboxVC
//            }
//        }
    }

}
