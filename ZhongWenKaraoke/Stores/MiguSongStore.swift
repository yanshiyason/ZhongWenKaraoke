//
//  MiguSongStore.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/21/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation

class MiguSongStore {
    var songs: [MiguSong]?
    init() {
        MiguDataService().getHomePageSongs { miguSongs, error in
            if error == nil {
                self.songs = miguSongs!
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "songsArrived"), object: nil)
            } else {
                print(error!)
                self.songs = nil
            }
        }
    }
}
