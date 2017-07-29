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
//import Foundation
//import UIKit
//import Alamofire
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
//let urlDecoded = "http://tyst.migu.cn/public/product01/2017/07/2017年07月03日11点35分紧急内容准入SONY259首/全曲试听/Mp3_128_44_16/Praying-Kesha.mp3?msisdn=99f246f5bd2d"
//let urlEncoded = urlDecoded.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//print(urlEncoded.lengthOfBytes(using: .utf8))
//
//let urlFilename = urlDecoded.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)!
//let url = URL(string: urlEncoded)!
//
//
//let destination: DownloadRequest.DownloadFileDestination = { _, _ in
//    var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//    print(documentsURL.appendPathComponent("12321_123321"))
//    return (documentsURL, [.removePreviousFile])
//}
//
////var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//documentsURL.appendPathComponent("12321_123321.mp3")
//print(documentsURL)
//print(documentsURL.appendPathComponent("12321_123321.mp3"))
//
//URL(string: documentsURL.absoluteString) == documentsURL





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
















//import AVFoundation
//import Pantry
//
//class MiguAVURLAsset: AVURLAsset {
//    // TODO: implement ways to find out playback time
//    init(_ miguSong: URL) {
//        super.init(url: miguSong, options: nil)
//    }
//    //    let mp3Asset = AVURLAsset(URL: NSURL(fileURLWithPath: safeMp3Url))
//    func totalDurationInSeconds() -> Int {
//        return 1
//    }
//    
//    func currentPlaybackTimeInSeconds() -> Int {
//        return 1
//    }
//}
//
//var u = URL(string: "http://www.mylocation.com/file.mp3")!
//var m = MiguAVURLAsset(u)





//import Foundation

//let isoDate = "00:4:20"
//
//let dateFormatter = DateFormatter()
////dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//dateFormatter.dateFormat = "HH:mm:ss"
//let date = dateFormatter.date(from:isoDate)!
////date.
//let calendar = Calendar.current
//let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
//let finalDate = calendar.date(from:components)


//parseTimeStampTo_ms(timeStamp){
//    let regexResult = timeStamp.match(/(\d{2})\:(\d{2}\.\d{2})/)
//    let minutes = (1000 * 60) * +regexResult[1]
//    let seconds = 1000 * +regexResult[2]
//    return minutes + seconds
//}

//let timestamp = "03:58.99"
//func timestampToSeconds (_ timestamp: String) -> Float {
//    let minSecFractionsRegex = "(\\d{2,}):(\\d{2,})\\.(\\d{2,})"
//    do {
//        let regex = try NSRegularExpression(pattern: minSecFractionsRegex)
//        let nsString = timestamp as NSString
//        let results = regex.matches(in: timestamp, range: NSRange(location: 0, length: nsString.length))
//        let minutes = Int(nsString.substring(with: results[0].rangeAt(1)))! * 60
//        let seconds = Int(nsString.substring(with: results[0].rangeAt(2)))!
//        let ms      = nsString.substring(with: results[0].rangeAt(3))
//        let result  = Float("\(minutes + seconds).\(ms)")!
//        return result
//    } catch let error {
//        print("invalid regex: \(error.localizedDescription)")
//        return Float(0)
//    }
//}
//
//
//func secondsToHoursMinutesSeconds (_ seconds : Int) -> (Int, Int, Int) {
//    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
//}
//
//timestampToSeconds(timestamp)
//
//
//secondsToHoursMinutesSeconds(60)
//















//
//
//import Foundation
//
//var d1 = Date()
//var d2 = Date()
//
//let date = Date()
//
//let dateComponents = Calendar.current.dateComponents([.second], from: date)
//let seconds = dateComponents.second
//print(String(describing: seconds)) // may print: Optional(13)
//
//



let dict: [String:[String:String]] = [
    "a": [
        "b":"c",
        "d":"e",
    ],
    "f": [
    "b":"c",
    "d":"e",
    ]
]

print(dict["a"]!["b"])