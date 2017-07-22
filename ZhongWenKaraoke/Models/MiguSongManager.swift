//
//  MiguSongManager.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/21/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation

class MiguSongManager {
    var songs: [MiguSong]?
    init() {
        MiguDataService().getHomePageSongs { miguSongs, error in
            if error == nil {
                self.songs = miguSongs!
            } else {
                print(error!)
                self.songs = nil
            }
        }
    }
}
