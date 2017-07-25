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
    
    func downloadMp3(_ miguSongDetails: MiguSongDetails, handler: @escaping (URL?) -> Void) {
        print("starting download!")
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent(miguSongDetails.mp3FileName)
            print("Downloading to: \(documentsURL)")
            return (documentsURL, [.removePreviousFile])
        }
        
        Alamofire.download(miguSongDetails.safeMp3Url, to: destination).responseData { response in
            print("inside download handler")
            if let destinationUrl = response.destinationURL {
                print("destinationUrl was valid! \(destinationUrl)")
                handler(destinationUrl)
            } else {
                print("destinationUrl was invalid! \(response)")
            }
        }
    }
    
    

    func getLyrics(_ miguSong: MiguSong, handler: @escaping (MiguSongLyrics?, Error?) -> Void) {
        get(miguSong.lyricsUrl) {data, error in
            if error == nil {
                handler(MiguSongLyrics(data!), nil)
            } else {
                print(error!)
                handler(nil, error)
            }
        }
    }

    func getSongDetails(_ miguSong: MiguSong, handler: @escaping (MiguSongDetails?, Error?) -> Void) {
        get(miguSong.songDetailsUrl) {data, error in
            if(error == nil) {
                handler(MiguSongDetails(fromJson: data!)!, nil)
            } else {
                print(error!)
                handler(nil, error)
            }
        }
    }
    
    func getHomePageSongs(_ handler: @escaping ([MiguSong]?, Error?) -> ()) {
        get(homePageUrl) { data, error in
            if (error == nil) {
                let utf8Text = String(data: data!, encoding: .utf8)
                handler(self.parseHomePage(utf8Text!), nil)
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
    
    func parseSongDetailsPage(_ json: Data) -> MiguSongDetails {
        return MiguSongDetails(fromJson: json)!
    }
    
    func get(_ url: String, handler: @escaping (Data?, Error?) -> ()) {
        Alamofire.request(url).responseData { response in
            switch response.result {
            case .success(let value):
                handler(value, nil)
            case .failure(let error):
                handler(nil, error)
            }
        }
    }
}

