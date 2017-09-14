//
//  MiguSongLyrics.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/23/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation
import Pantry

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
            return LyricLine(timestamp: $0, rawText: $0)
        }
    }
    
    func lineIndex(for seconds: Float) -> Int {
        
        if let i = lyrics.index(where: { $0.timestampToSeconds() >= seconds }) {
            return i - 1
        } else {
            return 0
        }
    }
}

struct LyricLine {
    var timestamp: String
    var rawText: String
    
    func text() -> String {
        do {
            let regex = try NSRegularExpression(pattern: LyricLine.textRe)
            let nsString = rawText as NSString
            let results = regex.matches(in: timestamp, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                return ""
            }

            return nsString.substring(with: results[0].rangeAt(1))
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return ""
        }
    }

    static let textRe = "\\[.+\\](.+)"
    static let minSecFractionsRegex = "(\\d{2,}):(\\d{2,})\\.(\\d{2,})"
    
    func timestampToSeconds () -> Float {
        do {
            
            let regex = try NSRegularExpression(pattern: LyricLine.minSecFractionsRegex)
            let nsString = timestamp as NSString
            let results = regex.matches(in: timestamp, range: NSRange(location: 0, length: nsString.length))

            if results.count == 0 {
                return Float(0)
            }
            
            let minutes = Int(nsString.substring(with: results[0].rangeAt(1)))! * 60
            let seconds = Int(nsString.substring(with: results[0].rangeAt(2)))!
            let ms      = nsString.substring(with: results[0].rangeAt(3))
            let result  = Float("\(minutes + seconds).\(ms)")!
            return result
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return Float(0)
        }
    }
}

extension LyricLine: Equatable {
    static func == (lhs: LyricLine, rhs: LyricLine) -> Bool {
        return (
            lhs.rawText == rhs.rawText &&
                lhs.timestamp == rhs.timestamp
        )
    }
    
}



extension MiguSongLyrics: Storable {
    // Pantry: Storable
    init(warehouse: Warehouseable) {
        self.rawLyrics = warehouse.get("rawLyrics") ?? ""
        self.lyrics = MiguSongLyrics.parseLyrics(rawLyrics)
    }
    
    func toDictionary() -> [String : Any] {
        return ["rawLyrics": self.rawLyrics]
    }
}
