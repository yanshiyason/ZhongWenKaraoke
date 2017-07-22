//
//  TopViewDataService.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/22/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation
import UIKit

class TopViewDataService: NSObject {
    var miguSongStore: MiguSongStore = AppDelegate.miguSongStore
}

extension TopViewDataService: UITableViewDelegate {
}

extension TopViewDataService: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MiguSongCell", for: indexPath) as! MiguSongCell
        
        if let song = miguSongStore.songs?[indexPath.row] {
            cell.config(withSong: song)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return miguSongStore.songs?.count ?? 0
    }
}
