//
//  MiguSongCell.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/22/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit

@IBDesignable
class MiguSongCell: UICollectionViewCell {
    var song: MiguSong!

    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(withSong song: MiguSong) {
        self.song = song
        if let poster = song.songDetails?.poster {
            self.posterImg?.setImageFromURl(poster)
//            self.posterImg?.borderRadius()
        }
        
        let songTitle = song.songDetails?.songName?.removingPercentEncoding! ?? ""
        let artistName = song.songDetails?.singerName ?? ""
        
        self.songTitle.attributedText = UILabel.strokedText(songTitle, font: .systemFont(ofSize: 20))
        self.artistName?.attributedText = UILabel.strokedText(artistName, font: .systemFont(ofSize: 16))
    }
    
}
