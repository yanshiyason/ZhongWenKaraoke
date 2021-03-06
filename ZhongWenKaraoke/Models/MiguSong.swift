//
//  MiguSong.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/20/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation
import Pantry

struct MiguSong {

    func isValid() -> Bool {
        guard let sd = songDetails else { return false }
        guard let sl = songLyrics else { return false }
        return sd.safeMp3Url != nil
    }

    var songDetails: MiguSongDetails? {
        set {
            if let newValue = newValue {
                if newValue.mp3 != nil {
                    Pantry.pack(newValue, key: "songDetails_\(itemId)")
                }
            }
        }
        get {
            return Pantry.unpack("songDetails_\(itemId)")
        }
    }

    var songLyrics: MiguSongLyrics? {
        set {
            if let newValue = newValue {
                Pantry.pack(newValue, key: "songLyrics_\(itemId)")
            }
        }
        get {
            return Pantry.unpack("songLyrics_\(itemId)")
        }
    }

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
    
    var localOrRemoteUrl: URL? {
        if let filePath: String = Pantry.unpack(songDetails!.mp3FileName) {
            return URL(string: filePath)!
        } else {
            guard let url = songDetails!.safeMp3Url else { return nil }
            return URL(string: url)
        }
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

extension MiguSong: Storable {
    // Pantry: Storable
    init(warehouse: Warehouseable) {
        self.artist = warehouse.get("artist") ?? ""
        self.song   = warehouse.get("song") ?? ""
        self.url    = warehouse.get("url") ?? ""
        self.itemId = warehouse.get("itemId") ?? ""
        self.loc    = warehouse.get("loc") ?? ""
        self.locno  = warehouse.get("locno") ?? ""
    }
    
    func toDictionary() -> [String : Any] {
        return [
            "artist": self.artist,
            "song": self.song,
            "url": self.url,
            "itemId": self.itemId,
            "loc": self.loc,
            "locno": self.locno,
        ]
    }
}
