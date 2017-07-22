//
//  MiguSongDetails.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/21/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation

struct MiguSongDetails {
    let albumId: Int
    let albumName, cmp3, copyright_id, hdmp3, mp3, mp4,
        poster, singerId, singerName, songId, songName: String
    
    init?(fromJson json: Data) {
        let object = try! JSONSerialization.jsonObject(with: json, options: .allowFragments) as! [String: Any]
        if let msg = object["msg"] as! [[String: Any]?]?,
            let jsonObject = msg[0] {
            self.albumId = jsonObject["albumId"] as! Int
            self.albumName = jsonObject["albumName"] as! String
            self.cmp3 = jsonObject["cmp3"] as! String
            self.copyright_id = jsonObject["copyright_id"] as! String
            self.hdmp3 = jsonObject["hdmp3"] as! String
            self.mp3 = jsonObject["mp3"] as! String
            self.mp4 = jsonObject["mp4"] as! String
            self.poster = jsonObject["poster"] as! String
            self.singerId = jsonObject["singerId"] as! String
            self.singerName = jsonObject["singerName"] as! String
            self.songId = jsonObject["songId"] as! String
            self.songName = jsonObject["songName"] as! String
        } else {
            return nil
        }
    }
    
}