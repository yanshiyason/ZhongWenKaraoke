////import Foundation
////
////var s = "http://tyst.migu.cn/public/ringmaker01/n16/2017/01/2013年04月16日声影网络内容准入244首/全曲试听/Mp3_128_44_16/涛声依旧-毛宁.mp3?msisdn=ba3139b35931"
////
////let safeUrl = s.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//////let url : NSString = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=\(self.latitud‌​e),\(self.longitude)&destinations=\(self.stringForDistance)&language=en-US"
//////let urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
//////let searchURL : NSURL = NSURL(string: urlStr as String)!
////print(safeUrl!)
////
////URL(string: safeUrl!)
//
//
////import Foundation
////import Jukebox
////
////class JukeboxService: Jukebox {
////    static var jukebox: Jukebox!
////    var setableDelegate: JukeboxDelegate?
////    override var delegate: JukeboxDelegate? {
////        get { return setableDelegate }
////        set { setableDelegate = newValue }
////    }
////}
////let v = JukeboxService()
//
import Foundation
//import UIKit
import Alamofire
//import Jukebox
//import AVKit
//import AVFoundation
//
//class JukeboxService: JukeboxDelegate {
//    func jukeboxStateDidChange(_ jukebox: Jukebox) {
//    }
//    
//    func jukeboxPlaybackProgressDidChange(_ jukebox: Jukebox) {
//    }
//    
//    func jukeboxDidLoadItem(_ jukebox: Jukebox, item: JukeboxItem) {
//    }
//    
//    func jukeboxDidUpdateMetadata(_ jukebox: Jukebox, forItem: JukeboxItem) {
//        print("Item updated:\n\(forItem)")
//    }
//    
//}
//
//print(NAME_MAX)
//
let urlDecoded = "http://tyst.migu.cn/public/product01/2017/07/2017年07月03日11点35分紧急内容准入SONY259首/全曲试听/Mp3_128_44_16/Praying-Kesha.mp3?msisdn=99f246f5bd2d"
let urlEncoded = urlDecoded.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
print(urlEncoded.lengthOfBytes(using: .utf8))

let urlFilename = urlDecoded.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)!
let url = URL(string: urlEncoded)!


let destination: DownloadRequest.DownloadFileDestination = { _, _ in
    var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    print(documentsURL.appendPathComponent("12321_123321"))
    return (documentsURL, [.removePreviousFile])
}

//var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
documentsURL.appendPathComponent("12321_123321.mp3")
print(documentsURL)
print(documentsURL.appendPathComponent("12321_123321.mp3"))

URL(string: documentsURL.absoluteString) == documentsURL





//
////JukeboxItem(URL: URL(string: miguSong.songDetails!.safeMp3Url)!)
//
////let ji = JukeboxItem(URL: )
//
//let asset = AVURLAsset(url: url)
//
//let audioDuration = asset.duration
//let audioDurationSeconds = CMTimeGetSeconds(audioDuration)
//
////let ji = JukeboxItem()
//
//let jukebox = Jukebox(delegate: JukeboxService(), items: [])
//
//
//AVAssetExportSession.exportPresets(compatibleWith: asset)[5]
//let quality = "AVAssetExportPresetHighestQuality"
//
//let session = AVAssetExportSession(asset: asset, presetName: quality)!
//session.outputURL = URL(string: "name")
////session.outputFileType = "mp3"
//print(session.supportedFileTypes)
////session.exportAsynchronously { f in
////    print(f)
////}
//
////manager.requestAVAsset(forVideo: asset, options: nil, resultHandler: { (avasset, audio, info) in
////    if let avassetURL = avasset as? AVURLAsset {
////        guard let video = try? Data(contentsOf: avassetURL.url) else {
////            return
////        }
////        videoData = video
////    }
////})
