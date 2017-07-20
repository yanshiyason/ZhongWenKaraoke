////: Playground - noun: a place where people can play
//
//import UIKit
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

func doIt(_ i: Int) -> Int { return i * 2 }
doIt(3)
for i in [1,2,3] { doIt(i) }
