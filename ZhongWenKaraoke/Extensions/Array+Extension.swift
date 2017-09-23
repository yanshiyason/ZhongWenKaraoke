//
//  Array+Extension.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 9/24/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return Int(index) < count ? self[index] : nil
    }
}
