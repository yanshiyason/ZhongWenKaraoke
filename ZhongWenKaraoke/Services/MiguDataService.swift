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
    
    

//    func lyrics(_ miguSong: MiguSong) -> String {
//        get(miguSong.lyricsUrl)
//    }
    
    //    func mp3(_ miguSong: MiguSong) -> String {
    //        get(miguSong.mp3Url)
    //    }
    
    public func getHomePageSongs(_ handler: @escaping ([MiguSong]?, Error?) -> ()) {
        get(homePageUrl) { string, error in
            if (error == nil) {
                handler(self.parseHomePage(string!), nil)
            } else {
                print(error!)
                handler(nil, error!)
            }
        }
    }
    
    
//    let homePageUrl = "http://music.migu.cn/184_11.html"
    let homePageUrl = "http://music.migu.cn/tag/1000587717/P2Z1Y1L2N1/1/001002A"

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
    
    func parseLyricsPage(_ json: Data) -> String {
        return try! JSONSerialization.jsonObject(with: json, options: .allowFragments) as! String
    }
    
    func parseSongDetailsPage(_ json: Data) -> String {
        return try! JSONSerialization.jsonObject(with: json, options: .allowFragments) as! String
    }
    
    func get(_ url: String, handler: @escaping (String?, Error?) -> ()) {
        Alamofire.request(url).responseData { response in
            switch response.result {
            case .success(let value):
                let utf8Text = String(data: value, encoding: .utf8)
                handler(utf8Text, nil)
            case .failure(let error):
                handler(nil, error)
            }
        }
    }
}

