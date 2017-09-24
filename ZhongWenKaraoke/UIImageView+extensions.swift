//
//  UIImageView+extensions.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/23/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageFromURl(_ url: String){
        if let url = URL(string: url) {
            kf.indicatorType = .activity
            kf.setImage(with: url)
        }
    }
}
