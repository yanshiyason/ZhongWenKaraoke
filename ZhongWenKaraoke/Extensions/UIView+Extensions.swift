//
//  UIView+Extensions.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 9/16/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.borderWidth = 1.0
            layer.borderColor = UIColor.clear.cgColor
            layer.cornerRadius = newValue
            
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                layer.masksToBounds = true
            }
        }
    }
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius

        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func borderRadius(_ radius: CGFloat = 10.0) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func borderRadiusLeftSide(_ radius: CGFloat = 10.0) {
        //        borderRadius(radius)
        //        if #available(iOS 11.0, *) {
        //            layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        //        }
        //        self.roundCorners([.topLeft, .bottomLeft], radius: 10)
        roundCorners([.topLeft, .bottomLeft], radius: 10)
    }
}
