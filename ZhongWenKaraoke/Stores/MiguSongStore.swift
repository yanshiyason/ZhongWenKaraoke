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
    static var hasOnGoingRequest = Variable(false)
    
    static func categorySongsKey(_ category: MiguCategory) -> String {
        return category.english
    }
    
    static func songsFor(category: MiguCategory) {
        if let songs: [MiguSong] = Pantry.unpack(self.categorySongsKey(category)) {
            print("about to change value")
            MiguSongStore._songs.onNext(songs)
        } else {
            MiguSongStore.hasOnGoingRequest.value = true
            MiguDataService().getSongsFor(category: category) { songs, error in
                if let songs = songs {
                    MiguSongStore.tempSongHolder = songs
                    let totalSongsCount = songs.count
                    var songsFetchedCounter = 0
                    MiguSongStore.fetchSongAssociations() { count, group in
                        
                        group.notify(queue: .main) {
                            songsFetchedCounter += 1
                            print("dispatching valid songs to change value")
                            MiguSongStore._songs.onNext(MiguSongStore.tempSongHolder.filter{$0.isValid()})

                            print("songsFetchedCounter: \(songsFetchedCounter) | totalSongsCount: \(totalSongsCount)")
                            
                            if songsFetchedCounter == totalSongsCount {
                                MiguSongStore.hasOnGoingRequest.value = false
                            }
                        }
                    }
                    Pantry.pack(songs, key: self.categorySongsKey(category))
                }
            }
        }
    }

    static func fetchSongAssociations(_ handler: @escaping (Int, DispatchGroup) -> ()) {
        print("fetching song lyrics and details in #fetchSongAssociations()")
        
        for (i, song) in MiguSongStore.tempSongHolder.enumerated() {
            
            let group = DispatchGroup()

            if (song.songDetails == nil) {
                group.enter()
                MiguDataService().getSongDetails(song) { songDetails, error in
                    if (songDetails != nil) {
                        MiguSongStore.tempSongHolder[i].songDetails = songDetails!
                    }
                    group.leave()
                }
            }
            
            if (song.songLyrics == nil) {
                group.enter()
                MiguDataService().getLyrics(song) {lyrics, error in
                    if (lyrics != nil) {
                        MiguSongStore.tempSongHolder[i].songLyrics = lyrics!
                        
                    }
                    group.leave()
                }
            }
            
            
            handler(i, group)
        }
        MiguSongStore._songs.onNext(MiguSongStore.tempSongHolder.filter{$0.isValid()})
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
