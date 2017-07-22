//
//  MiguSongCell.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/22/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit

@IBDesignable
class MiguSongCell: UITableViewCell {
    var song: MiguSong!
    
    
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var shadowRadius: CGFloat = 0
    @IBInspectable var shadowOpacity: Float = 0
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    @IBInspectable var shadowColor: CGColor?


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setup()
    }
    
    func setup() {
        layer.borderWidth = borderWidth
        layer.shadowOffset = shadowOffset
        layer.shadowColor = shadowColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func config(withSong song: MiguSong) {
        self.song = song
        self.textLabel?.text = song.song
        self.detailTextLabel?.text = song.artist
    }
    
}
