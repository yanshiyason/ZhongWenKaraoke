////: Playground - noun: a place where people can play
//
import UIKit
//import Alamofire
////import Kanna
//
//var str = "Hello, playground"
//
//
//let file = "file.txt" //this is the file. we will write to and read from it
//
//let text = "some text" //just a text
//
//var paths = FileManager.default.urls(for: .userDirectory, in: .localDomainMask)
//var paths2 = FileManager.default.urls(for: .userDirectory, in: .allDomainsMask)
//
//if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//    
//    let path = dir.appendingPathComponent(file)
//    
//    //writing
//    do {
//        try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
//    }
//    catch {/* error handling here */}
//    
//    //reading
//    do {
//        let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
//    }
//    catch {/* error handling here */}
//}

//func doIt(_ i: Int) -> Int { return i * 2 }
//doIt(3)
//for i in [1,2,3] { doIt(i) }

import Foundation

func HtmlFixtureURL(_ title: String) -> URL {
    return Bundle.main.url(forResource: title, withExtension: "html")!
}

func JsonFixtureURL(_ title: String) -> URL {
    return Bundle.main.url(forResource: title, withExtension: "json")!
}

func HtmlFromFixture(_ title: String) -> String {
    let data = try! Data.init(contentsOf: HtmlFixtureURL(title))
    return String(data: data, encoding: .utf8)!
}

func JsonFromFixture(_ title: String) -> Data {
    return try! Data.init(contentsOf: JsonFixtureURL(title))
}

let json = JsonFromFixture("songDetails")
let object = try! JSONSerialization.jsonObject(with: json, options: .allowFragments) as! [String: Any]
//if let msg = object["msg"] as! [[String: Any]?]?,
//    let jsonObject = msg[0] {
//    print("something")
//    print(jsonObject)
//}



//struct MiguSongDetails {
//    let albumId: Int
//    let albumName, cmp3, copyright_id, hdmp3,
//    mp3, mp4, poster, singerId, singerName,
//    songId, songName: String
//    
//    init(json: Data) {
//        self.albumId
//    }
//    
//}

//{
//    "albumId": 1106678346,
//    "albumName": "Praying",
//    "cmp3": "http://tyst.migu.cn/public/product01/2017/07/2017年07月03日11点35分紧急内容准入SONY259首/彩铃/6_mp3-128kbps/Praying-Kesha.mp3?msisdn=757b8eb33fbe",
//    "copyright_id": "6005970RXHS",
//    "hdmp3": "http://tyst.migu.cn/public/product01/2017/07/2017年07月03日11点35分紧急内容准入SONY259首/全曲试听/Mp3_320_44_16/Praying-Kesha.mp3?msisdn=386a078979c7",
//    "mp3": "http://tyst.migu.cn/public/product01/2017/07/2017年07月03日11点35分紧急内容准入SONY259首/全曲试听/Mp3_128_44_16/Praying-Kesha.mp3?msisdn=99f246f5bd2d",
//    "mp4": "http://tyst.migu.cn/public/product01/2017/07/2017年07月03日11点35分紧急内容准入SONY259首/杜比/mp4_128/Praying-Kesha.mp4?msisdn=0f5b970f921a",
//    "poster": "http://img01.12530.com/music/picture/20170707/79/97/C1TC4iBD.jpg_RsT_200x200.jpg",
//    "singerId": "1001205694",
//    "singerName": "Ke$ha",
//    "songId": "1106678347",
//    "songName": "Praying"
//}
