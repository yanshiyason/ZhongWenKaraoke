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
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "songsArrived"), object: nil)
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
                        debugPrint("Fetched \(songDetails)")
                        if (songDetails != nil) {
                            self.songs?[i].songDetails = songDetails!
                        }
                    }
                }
                
                if (song.songLyrics == nil) {
                    MiguDs.getLyrics(song) {lyrics, error in
                        debugPrint("Fetched \(lyrics)")
                        if (lyrics != nil) {
                            self.songs?[i].songLyrics = lyrics!
                        }
                    }
                }
            }
        }
    }
}
