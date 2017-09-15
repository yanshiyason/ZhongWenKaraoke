//
//  UILabel+Extension.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 9/15/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    static func coloredText(_ text: String, color: UIColor = .black, font: UIFont = .systemFont(ofSize: 14)) -> NSMutableAttributedString {

        let strokeTextAttributes = [
            NSForegroundColorAttributeName : color,
            NSFontAttributeName : font
        ] as [String : Any]
        
        return NSMutableAttributedString(string: text, attributes: strokeTextAttributes)
    }

    static func strokedText(_ text: String,
                     strokeColor: UIColor = .black,
                     foregroundColor: UIColor = .white,
                     strokeWidth: Float = -2.0,
                     font: UIFont =  .systemFont(ofSize: 21)) -> NSMutableAttributedString {

        let strokeTextAttributes = [
            NSStrokeColorAttributeName : strokeColor,
            NSForegroundColorAttributeName : foregroundColor,
            NSStrokeWidthAttributeName : strokeWidth,
            NSFontAttributeName : font
        ] as [String : Any]
        
        return NSMutableAttributedString(string: text, attributes: strokeTextAttributes)
    }
}
