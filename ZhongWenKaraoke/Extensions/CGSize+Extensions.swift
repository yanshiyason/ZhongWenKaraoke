//
//  CGSize+Extensions.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 9/24/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation
import UIKit

extension CGSize {
    static func / (lhs: CGSize, rhs: Float) -> CGSize {
        let height = lhs.height / CGFloat(rhs)
        let width = lhs.width / CGFloat(rhs)
        return CGSize(width: width, height: height)
    }
}
