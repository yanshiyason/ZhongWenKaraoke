//
//  CCCEdict.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/29/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation

struct CCCEdict {
    typealias Dictionary = [String:[String:String]]
    typealias Entry = [String:String]

    static let dictionary: Dictionary = {
        let url = Bundle.main.url(forResource: "dictionary", withExtension: "json")
        let data = try! Data.init(contentsOf: url!)
        return try! JSONSerialization.jsonObject(with: data, options: []) as! [String:[String:String]]
    }()
    
    // simplified pinyinify function
    static func pinyinify(_ text: String) -> String {
        let results = CCCEdict.cut(text)
        var pinyinString = ""
        for r in results {
            if let noHit = r["notAWord"] {
                pinyinString += noHit
            } else {
                pinyinString += (r["pinyin"] ?? "").replacingOccurrences(of: " ", with: "")
                pinyinString += " "
            }
        }
        return pinyinString
    }
    
    static func simplified(_ text: String) -> String {
        let results = CCCEdict.cut(text)
        var simplifiedString = ""
        for r in results {
            if let noHit = r["notAWord"] {
                simplifiedString += noHit
            } else {
                simplifiedString += (r["simplified"] ?? "")
            }
        }
        return simplifiedString
    }
    
    static func traditional(_ text: String) -> String {
        let results = CCCEdict.cut(text)
        var traditionalString = ""
        for r in results {
            if let noHit = r["notAWord"] {
                traditionalString += noHit
            } else {
                traditionalString += (r["traditional"] ?? "")
            }
        }
        return traditionalString
    }
    
    // more complex pinyinify function. Tries to maintain spaces.
//    static func pinyinify(_ text: String) -> String {
//        let results = CCCEdict.cut(text)
//        let lastResultsIndex = results.count - 1
//        var pinyinString = ""
//        var needsSpace = true
//        for (i, r) in results.enumerated() {
//            var nextResult = results[safe: (i + 1)]
//            if let noHit = r["notAWord"] {
//                pinyinString += noHit
//                needsSpace = false
//            } else {
//                pinyinString += (r["pinyin"] ?? "").replacingOccurrences(of: " ", with: "")
//                needsSpace = true
//                if nextResult != nil && nextResult!["notAWord"] != nil {
//                    needsSpace = false
//                }
//            }
//            
//            if needsSpace && i < lastResultsIndex {
//                pinyinString += " "
//            }
//        }
//        return pinyinString
//    }

    static func cut(_ text: String) -> [Entry] {
        if text.characters.count == 0 {
            return [Entry]()
        }
        
        var pointer = (0, Entry())
        let longestWordCheck = 7
        var results = [Entry]()
        for i in 1...text.characters.count {
            if (i <= pointer.0 ) { continue }
            
            let remainingText = text.substring(from: pointer.0)
            
            var found = false
            var longestWord = Entry()
            for j in 1...(longestWordCheck.clamped(to: 0...remainingText.characters.count)) {
                let query = remainingText.substring(to: j)
                if let hit = CCCEdict.dictionary[query] {
                    pointer.0 = j + i - 1
                    longestWord = hit
                    found = true
                }
            }
            
            if found {
                pointer.1 = longestWord
                results.append(pointer.1)
            } else {
                pointer.0 = i
                results.append(["notAWord": text.substring(at: i)])
            }
            
        }
        return results
    }
}


extension String {
    func toPinyin() -> String {
        return CCCEdict.pinyinify(self)
    }
    func toSimplified() -> String {
        return CCCEdict.simplified(self)
    }
    func toTraditional() -> String {
        return CCCEdict.traditional(self)
    }
}
