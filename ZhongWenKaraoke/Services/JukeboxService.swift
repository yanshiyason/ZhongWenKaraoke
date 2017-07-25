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
    static var jukeboxVC: JukeboxViewController?
    static var jukeboxService = JukeboxService()
    static var jukebox = Jukebox(delegate: jukeboxService)!

    func jukeboxStateDidChange(_ jukebox: Jukebox) {
        
        if jukebox.state == .ready {
            JukeboxService.jukeboxVC!.playPauseBtn.setImage(UIImage(named: "playBtn"), for: UIControlState())
        } else if jukebox.state == .loading {
            JukeboxService.jukeboxVC!.playPauseBtn.setImage(UIImage(named: "pauseBtn"), for: UIControlState())
        } else {
            let imageName: String
            switch jukebox.state {
            case .playing, .loading:
                imageName = "pauseBtn"
            case .paused, .failed, .ready:
                imageName = "playBtn"
            }
            JukeboxService.jukeboxVC!.playPauseBtn.setImage(UIImage(named: imageName), for: UIControlState())
        }
        print("Jukebox state changed to \(jukebox.state)")
    }
    
    func jukeboxPlaybackProgressDidChange(_ jukebox: Jukebox) {
        
    }
    
    func jukeboxDidLoadItem(_ jukebox: Jukebox, item: JukeboxItem) {
        
    }
    
    func jukeboxDidUpdateMetadata(_ jukebox: Jukebox, forItem: JukeboxItem) {
        print("Item updated:\n\(forItem)")
    }
    
}
