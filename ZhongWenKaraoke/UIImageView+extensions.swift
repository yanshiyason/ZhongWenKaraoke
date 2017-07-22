//
//  UIImageView+extensions.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/23/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit
extension UIImageView {
    func setImageFromURl(_ url: String){
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}
