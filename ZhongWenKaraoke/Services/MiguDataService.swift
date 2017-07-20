//
//  MiguDataService.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/19/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation
import Alamofire
import Kanna

class MiguDataService {
    func parseHomePage(_ html: String) -> [MiguSong] {
        let doc = HTML(html: html, encoding: .utf8)!
        return doc.css(".singer_name").map { node in
            let songNode = node.parent
            let song = songNode?.at_css(".song_name")?.text!
            let url = songNode?.at_css(".song_name a")?["href"]!
            let artist = songNode?.at_css(".singer_name")?.text!
            return MiguSong(artist: artist!, song: song!, url: url!)
        }
    }
}
