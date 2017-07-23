//
//  MiguSongStore.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/21/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation

class MiguSongStore {
    let MiguDs = MiguDataService()
    var songs: [MiguSong]?
    init() {
        MiguDataService().getHomePageSongs { miguSongs, error in
            if error == nil {
                self.songs = miguSongs!
                self.fetchSongAssociations()
                notifyNewSongs()
            } else {
                print(error!)
                self.songs = nil
            }
        }
    }
    
    func fetchSongAssociations() {
        if let songs = songs {
            for (i, song) in songs.enumerated() {

                if (song.songDetails == nil) {
                    MiguDs.getSongDetails(song) { songDetails, error in
                        debugPrint("Fetched \(String(describing: songDetails))")
                        if (songDetails != nil) {
                            self.songs?[i].songDetails = songDetails!
                            notifyNewSongs()
                        }
                    }
                }
                
                if (song.songLyrics == nil) {
                    MiguDs.getLyrics(song) {lyrics, error in
                        debugPrint("Fetched \(String(describing: lyrics))")
                        if (lyrics != nil) {
                            self.songs?[i].songLyrics = lyrics!
                            notifyNewSongs()
                        }
                    }
                }
            }
        }
    }
    
    func notifyNewSongs() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "songsArrived"), object: nil)
    }
}
