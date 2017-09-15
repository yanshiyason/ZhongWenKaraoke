//
//  MiguCategoryCell.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 8/2/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit

class MiguCategoryCell: UICollectionViewCell {
    @IBOutlet weak var chinese: UILabel!
    @IBOutlet weak var english: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configBorder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configBorder()
    }
    
    func configBorder() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
    
}
