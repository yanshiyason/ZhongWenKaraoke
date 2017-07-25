//
//  JukeboxService.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/25/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation
import Jukebox

class JukeboxService: JukeboxDelegate {
    func jukeboxStateDidChange(_ jukebox: Jukebox) {
        
        if AppDelegate.jukebox!.state == .ready {
            AppDelegate.jukeboxVC!.playPauseBtn.setImage(UIImage(named: "playBtn"), for: UIControlState())
        } else if AppDelegate.jukebox!.state == .loading {
            AppDelegate.jukeboxVC!.playPauseBtn.setImage(UIImage(named: "pauseBtn"), for: UIControlState())
        } else {
            let imageName: String
            switch AppDelegate.jukebox!.state {
            case .playing, .loading:
                imageName = "pauseBtn"
            case .paused, .failed, .ready:
                imageName = "playBtn"
            }
            AppDelegate.jukeboxVC!.playPauseBtn.setImage(UIImage(named: imageName), for: UIControlState())
        }
        print("Jukebox state changed to \(AppDelegate.jukebox!.state)")
    }
    
    func jukeboxPlaybackProgressDidChange(_ jukebox: Jukebox) {
        
    }
    
    func jukeboxDidLoadItem(_ jukebox: Jukebox, item: JukeboxItem) {
        
    }
    
    func jukeboxDidUpdateMetadata(_ jukebox: Jukebox, forItem: JukeboxItem) {
        print("Item updated:\n\(forItem)")
    }
    
}
