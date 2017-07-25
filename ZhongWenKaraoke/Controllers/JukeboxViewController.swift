//
//  JukeboxViewController.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/25/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit
import Jukebox

class JukeboxViewController: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var restartBtn: UIButton!
    @IBOutlet weak var songProgress: UIProgressView!
    
    var jukebox: Jukebox!
    var miguSong: MiguSong!
    override func viewDidLoad() {
        super.viewDidLoad()

        // begin receiving remote events
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        AppDelegate.jukebox!.stop()
        
        for item in AppDelegate.jukebox!.queuedItems {
            AppDelegate.jukebox!.remove(item: item)
        }
        
        let jukeboxItem: JukeboxItem = {
            if let filePath = miguSong.songDetails?.mp3FilePath {
                print("Found mp3 path: \(filePath)\nUsing local asset for jukebox item")
                return JukeboxItem(URL: URL(string: filePath)!)
            } else {
                print("Couldn't find local mp3 path\nStreaming from remote url")
                return JukeboxItem(URL: URL(string: miguSong.songDetails!.safeMp3Url)!)
            }
        }()
        
        AppDelegate.jukebox!.append(item: jukeboxItem, loadingAssets: true)
        AppDelegate.jukebox!.play()
        
//        jukebox = Jukebox(delegate: self, items: [
//            JukeboxItem(URL: URL(string: miguSong.songDetails!.safeMp3Url)!)
//        ])!

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prevAction(_ sender: Any) {
        if let time = AppDelegate.jukebox!.currentItem?.currentTime, time > 5.0 || AppDelegate.jukebox!.playIndex == 0 {
            AppDelegate.jukebox!.replayCurrentItem()
        } else {
            AppDelegate.jukebox!.playPrevious()
        }
    }
    @IBAction func nextAction(_ sender: Any) {
        AppDelegate.jukebox!.playNext()
    }
    @IBAction func playPauseAction(_ sender: Any) {
        switch AppDelegate.jukebox!.state {
        case .ready :
            AppDelegate.jukebox!.play(atIndex: 0)
        case .playing :
            AppDelegate.jukebox!.pause()
        case .paused :
            AppDelegate.jukebox!.play()
        default:
            AppDelegate.jukebox!.stop()
        }
    }
    @IBAction func stopAction(_ sender: Any) {
        AppDelegate.jukebox!.stop()
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
