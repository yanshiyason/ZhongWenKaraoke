//
//  MiguSong.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/20/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation

struct MiguSong {
    let urlRegex = "song/(\\d{1,})/(\\w{1,})/(\\d{1,})"
    let artist, song, url,
        itemId, loc, locno: String
    init(artist: String, song: String, url: String){
        self.artist = artist
        self.song = song
        self.url = url

        let matches = MiguSong.match(for: urlRegex, in: url)
        self.itemId = matches[1]
        self.loc    = matches[2]
        self.locno  = matches[3]
    }
    
    var lyricsUrl: String {
        return "http://music.migu.cn/webfront/player/lyrics.do?songid=\(itemId)"
    }
    
    var songDetailsUrl: String {
        return "http://music.migu.cn/webfront/player/findsong.do?itemid=\(itemId)&type=song&loc=\(loc)&locno=\(locno)"
    }
    
    static func match(for regex: String, in url: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = url as NSString
            let results = regex.matches(in: url, range: NSRange(location: 0, length: nsString.length))

            var data: [String] = []
            for i in 0 ..< results[0].numberOfRanges {
                data.append(nsString.substring(with: results[0].rangeAt(i)))
            }
            return data
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}

extension MiguSong: Equatable {
    static func == (lhs: MiguSong, rhs: MiguSong) -> Bool {
        return (
            lhs.artist == rhs.artist &&
                lhs.url == rhs.url &&
                lhs.song == rhs.song
        )
    }

}
