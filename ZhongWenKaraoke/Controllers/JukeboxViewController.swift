//
//  JukeboxViewController.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/25/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit
import Jukebox
import RxSwift
import RxCocoa

class JukeboxViewController: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var restartBtn: UIButton!
    @IBOutlet weak var songProgress: UIProgressView!
    var progress = Variable<Float>(0)
    
    var jukebox: Jukebox!
    var miguSong: MiguSong!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // begin receiving remote events
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        JukeboxService.jukebox.stop()
        
        for item in JukeboxService.jukebox.queuedItems {
            JukeboxService.jukebox.remove(item: item)
        }
        
        let jukeboxItem: JukeboxItem? = {
            if let filePath = miguSong.songDetails?.mp3FilePath {
                print("Found mp3 path: \(filePath)\nUsing local asset for jukebox item")
                return JukeboxItem(URL: URL(string: filePath)!)
            } else {
                print("Couldn't find local mp3 path\nStreaming from remote url")
                guard let url = miguSong.songDetails?.safeMp3Url else {
                    
                    return nil
                }
                return JukeboxItem(URL: URL(string: url)!)
            }
        }()
        
        if jukeboxItem == nil { return }
        
        JukeboxService.jukebox.append(item: jukeboxItem!, loadingAssets: true)
        JukeboxService.jukebox.play()
        

        JukeboxService.currentItem.asObservable()
            .subscribe {
                print($0)
            }
            .addDisposableTo(disposeBag)
        
        progress.asDriver().drive(onNext: {
            self.songProgress!.setProgress(Float($0), animated: false)
        })
        .addDisposableTo(disposeBag)
        
        JukeboxService.playbackTime.asObservable()
            .subscribe {
                if let time = $0.element ?? nil {
                    let duration = JukeboxService.currentItem.value?.meta.duration ?? 0
                    self.progress.value = (Float(time) / Float(duration)) * 1.0
                }
            }
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prevAction(_ sender: Any) {
        if let time = JukeboxService.jukebox.currentItem?.currentTime, time > 5.0 || JukeboxService.jukebox.playIndex == 0 {
            JukeboxService.jukebox.replayCurrentItem()
        } else {
            JukeboxService.jukebox.playPrevious()
        }
    }
    @IBAction func nextAction(_ sender: Any) {
        JukeboxService.jukebox.playNext()
    }
    @IBAction func playPauseAction(_ sender: Any) {
        switch JukeboxService.jukebox.state {
        case .ready :
            JukeboxService.jukebox.play(atIndex: 0)
        case .playing :
            JukeboxService.jukebox.pause()
        case .paused :
            JukeboxService.jukebox.play()
        default:
            JukeboxService.jukebox.stop()
        }
    }
    @IBAction func stopAction(_ sender: Any) {
        JukeboxService.jukebox.stop()
    }

}
