//
//  MiguSong.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/20/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation

struct MiguSong {
    let artist, song, url: String
    init(artist: String, song: String, url: String){
        self.artist = artist
        self.song = song
        self.url = url
    }
}
