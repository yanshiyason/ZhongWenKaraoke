//
//  JukeboxService.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/25/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation
import UIKit
import Jukebox
import RxSwift

class JukeboxService: JukeboxDelegate {
//    static var jukeboxVC: JukeboxViewController?
    static var jukeboxService = JukeboxService()
    
    static var jukebox = Jukebox(delegate: jukeboxService)!
    static var currentItem = Variable<JukeboxItem?>(nil)
    static var playbackTime = Variable<Double?>(nil)

    func jukeboxStateDidChange(_ jukebox: Jukebox) {
        
//        if jukebox.state == .ready {
//            JukeboxService.jukeboxVC!.playPauseBtn.setImage(UIImage(named: "playBtn"), for: UIControlState())
//        } else if jukebox.state == .loading {
//            JukeboxService.jukeboxVC!.playPauseBtn.setImage(UIImage(named: "pauseBtn"), for: UIControlState())
//        } else {
//            let imageName: String
//            switch jukebox.state {
//            case .playing, .loading:
//                imageName = "pauseBtn"
//            case .paused, .failed, .ready:
//                imageName = "playBtn"
//            }
//            JukeboxService.jukeboxVC!.playPauseBtn.setImage(UIImage(named: imageName), for: UIControlState())
//        }
        print("Jukebox state changed to \(jukebox.state)")
    }
    
    func jukeboxPlaybackProgressDidChange(_ jukebox: Jukebox) {
        JukeboxService.playbackTime.value = JukeboxService.currentItem.value?.currentTime ?? 0   
    }
    
    func jukeboxDidLoadItem(_ jukebox: Jukebox, item: JukeboxItem) {
        JukeboxService.currentItem.value = item
    }
    
    func jukeboxDidUpdateMetadata(_ jukebox: Jukebox, forItem: JukeboxItem) {
        print("Item updated:\n\(forItem)")
    }
    
    
    static let disposeBag = DisposeBag()
    static var progress = Variable<Float>(0)
    static func play() {
        // begin receiving remote events
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        JukeboxService.jukebox.stop()
        
        for item in JukeboxService.jukebox.queuedItems {
            JukeboxService.jukebox.remove(item: item)
        }
        
        let jukeboxItem: JukeboxItem? = {
            if let filePath = AppState.currentSong.songDetails?.mp3FilePath {
                print("Found mp3 path: \(filePath)\nUsing local asset for jukebox item")
                return JukeboxItem(URL: URL(string: filePath)!)
            } else {
                print("Couldn't find local mp3 path\nStreaming from remote url")
                guard let url = AppState.currentSong.songDetails?.safeMp3Url else {
                    
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
            .addDisposableTo(JukeboxService.disposeBag)
        
//        progress.asDriver().drive(onNext: {
//            self.songProgress!.setProgress(Float($0), animated: false)
//        })
//            .addDisposableTo(disposeBag)
        
        JukeboxService.playbackTime.asObservable()
            .subscribe {
                if let time = $0.element ?? nil {
                    let duration = JukeboxService.currentItem.value?.meta.duration ?? 0
                    JukeboxService.progress.value = (Float(time) / Float(duration)) * 1.0
                }
            }
            .addDisposableTo(JukeboxService.disposeBag)
    }
    
}
