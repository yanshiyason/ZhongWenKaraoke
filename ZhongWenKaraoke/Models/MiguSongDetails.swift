//
//  MiguSongDetails.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/21/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation
import AVFoundation
import Pantry

struct MiguSongDetails {
    let albumId: Int?
    let albumName: String?
    let cmp3, copyright_id, hdmp3, mp3, mp4,
    poster, singerId, singerName, songId, songName: String
    
    init?(fromJson json: Data) {
        let object = try! JSONSerialization.jsonObject(with: json, options: .allowFragments) as! [String: Any]
        if let msg = object["msg"] as! [[String: Any]?]?,
            let jsonObject = msg[0] {
            self.albumId = jsonObject["albumId"] as! Int?
            self.albumName = jsonObject["albumName"] as! String?
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
    
    var mp3FilePath: String? {
        get {
            if let filePath: String = Pantry.unpack(mp3FileName) {
                return filePath
            } else {
                fetchAndStoreMp3()
                return nil
            }
        }
    }
    
    func fetchAndStoreMp3() {
        MiguDataService().downloadMp3(self) { url in
            if let url = url {
                Pantry.pack(url.absoluteString, key: self.mp3FileName)
            }
        }
    }
    
    var safeMp3Url: String {
        return self.mp3.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    var mp3FileName: String {
        return "\(singerId)_\(songId).mp3"
    }
    
}


extension MiguSongDetails: Storable {
    // Pantry: Storable
    init(warehouse: Warehouseable) {
        self.albumId      = warehouse.get("albumId") ?? nil
        self.albumName    = warehouse.get("albumName") ?? ""
        self.cmp3         = warehouse.get("cmp3") ?? ""
        self.copyright_id = warehouse.get("copyright_id") ?? ""
        self.hdmp3        = warehouse.get("hdmp3") ?? ""
        self.mp3          = warehouse.get("mp3") ?? ""
        self.mp4          = warehouse.get("mp4") ?? ""
        self.poster       = warehouse.get("poster") ?? ""
        self.singerId     = warehouse.get("singerId") ?? ""
        self.singerName   = warehouse.get("singerName") ?? ""
        self.songId       = warehouse.get("songId") ?? ""
        self.songName     = warehouse.get("songName") ?? ""
    }
    
    func toDictionary() -> [String : Any] {
        return [
            "albumId": self.albumId ?? "",
            "albumName": self.albumName ?? "",
            "cmp3": self.cmp3,
            "copyright_id": self.copyright_id,
            "hdmp3": self.hdmp3,
            "mp3": self.mp3,
            "mp4": self.mp4,
            "poster": self.poster,
            "singerId": self.singerId,
            "singerName": self.singerName,
            "songId": self.songId,
            "songName": self.songName,
        ]
    }
}

