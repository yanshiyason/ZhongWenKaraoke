//
//  MiguSongLyrics.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/23/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation
struct MiguSongLyrics {
    var rawLyrics: String
    var lyrics: [LyricLine]

    init(_ rawLyrics: String) {
        self.rawLyrics = rawLyrics
        self.lyrics = MiguSongLyrics.parseLyrics(rawLyrics)
    }
    
    init(_ rawLyrics: Data) {
        let lyrics = try! JSONSerialization.jsonObject(with:rawLyrics, options: .allowFragments) as! String
        self.rawLyrics = lyrics
        self.lyrics = MiguSongLyrics.parseLyrics(lyrics)
    }

    static func parseLyrics(_ rawLyrics: String) -> [LyricLine] {
        return rawLyrics.components(separatedBy: "\n").map {
            return LyricLine(timestamp: $0, text: $0)
        }
    }
}

struct LyricLine {
    var timestamp: String
    var text: String
}
