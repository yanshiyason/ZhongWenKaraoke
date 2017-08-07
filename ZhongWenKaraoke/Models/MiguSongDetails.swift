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
    poster, singerId, singerName, songId, songName: String?
    
    init?(fromJson json: Data) {
        if let object = try? JSONSerialization.jsonObject(with: json, options: .allowFragments) as! [String: Any],
         let msg = object["msg"] as? [[String: Any?]?]?,
            let jsonObject = msg?[0] {
            self.albumId = jsonObject["albumId"] as? Int ?? nil
            self.albumName = jsonObject["albumName"] as? String ?? nil
            self.cmp3 = jsonObject["cmp3"] as? String ?? nil
            self.copyright_id = jsonObject["copyright_id"] as? String ?? nil
            self.hdmp3 = jsonObject["hdmp3"] as? String ?? nil
            self.mp3 = jsonObject["mp3"] as? String ?? nil
            self.mp4 = jsonObject["mp4"] as? String ?? nil
            self.poster = jsonObject["poster"] as? String ?? nil
            self.singerId = jsonObject["singerId"] as? String ?? nil
            self.singerName = jsonObject["singerName"] as? String ?? nil
            self.songId = jsonObject["songId"] as? String ?? nil
            self.songName = jsonObject["songName"] as? String ?? nil
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
    
    var safeMp3Url: String? {
        return self.mp3?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    var mp3FileName: String {
        return "\(singerId!)_\(songId!).mp3"
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
            "cmp3": self.cmp3 as Any,
            "copyright_id": self.copyright_id as Any,
            "hdmp3": self.hdmp3 as Any,
            "mp3": self.mp3 as Any,
            "mp4": self.mp4 as Any,
            "poster": self.poster as Any,
            "singerId": self.singerId as Any,
            "singerName": self.singerName as Any,
            "songId": self.songId as Any,
            "songName": self.songName as Any,
        ]
    }
}

