//
//  LyricLineCell.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/23/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit

class LyricLineCell: UITableViewCell {

    @IBOutlet weak var simplified: UILabel!
    @IBOutlet weak var tradOrpinyin: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
