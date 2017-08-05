//
//  MiguSongStore.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/21/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation
import RxSwift
import Pantry

class MiguSongStore {
    static var tempSongHolder: [MiguSong]!
    static var _songs = BehaviorSubject<[MiguSong]>(value: [MiguSong]())
    static var songs: Observable<[MiguSong]> = MiguSongStore._songs
//    static var songs = Variable<[MiguSong]>([MiguSong]())
    
    static func categorySongsKey(_ category: MiguCategory) -> String {
        return category.english
    }
    
    static func songsFor(category: MiguCategory) {
        if let songs: [MiguSong] = Pantry.unpack(self.categorySongsKey(category)) {
            print("about to change value")
            MiguSongStore._songs.onNext(songs)
//            MiguSongStore.songs.value = songs
        } else {
            MiguDataService().getSongsFor(category: category) { songs, error in
                if let songs = songs {
                    MiguSongStore.tempSongHolder = songs
                    MiguSongStore.fetchSongAssociations()
                    Pantry.pack(songs, key: self.categorySongsKey(category))
                }
            }
        }
    }
    
    static func fetchSongAssociations() {
        for (i, song) in MiguSongStore.tempSongHolder.enumerated() {

            if (song.songDetails == nil) {
                MiguDataService().getSongDetails(song) { songDetails, error in
//                    debugPrint("Fetched \(String(describing: songDetails))")
                    if (songDetails != nil) {
                        MiguSongStore.tempSongHolder[i].songDetails = songDetails!
                        
                        print("about to change value")
//                        MiguSongStore.songs.value = MiguSongStore.tempSongHolder
                        MiguSongStore._songs.onNext(MiguSongStore.tempSongHolder)
                    }
                }
            }
            
            if (song.songLyrics == nil) {
                MiguDataService().getLyrics(song) {lyrics, error in
//                    debugPrint("Fetched \(String(describing: lyrics))")
                    if (lyrics != nil) {
                        MiguSongStore.tempSongHolder[i].songLyrics = lyrics!
                        MiguSongStore._songs.onNext(MiguSongStore.tempSongHolder)
                        print("about to change value")
//                        MiguSongStore.songs.value = MiguSongStore.tempSongHolder
                    }
                }
            }
        }
        print("about to change value")
        MiguSongStore._songs.onNext(MiguSongStore.tempSongHolder)
//        MiguSongStore.songs.value = MiguSongStore.tempSongHolder
    }
    
    static let categories = loadCategories()
    
    private static func loadCategories() -> [MiguParentCategory] {
        let url = Bundle.main.url(forResource: "categories", withExtension: "json")
        let data = try! Data.init(contentsOf: url!)
        
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        let parentCategoriesJson = json["parent_categories"] as! [[String:Any]]
        return parentCategoriesJson.map { c in
            let categoriesArray = c["categories"]! as! [[String:String]]
            let categories = categoriesArray.map { c in
                MiguCategory(chinese: c["category"]!, english: c["en"]!, url: c["url"]!)
            }
            return MiguParentCategory(chinese:c["category"]! as! String, english: c["en"]! as! String, categories: categories)
        }
    }
    
    
}
