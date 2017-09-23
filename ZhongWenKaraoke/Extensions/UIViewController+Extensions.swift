//
//  UIViewController+Extensions.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 9/15/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideTabBar() {
        var frame = self.tabBarController?.tabBar.frame
        frame?.origin.y = self.view.frame.size.height + (frame?.size.height)!
        UIView.animate(withDuration: 0.25, animations: {
            self.tabBarController?.tabBar.frame = frame!
        })
    }
    
    func showTabBar() {
        var frame = self.tabBarController?.tabBar.frame
        frame?.origin.y = self.view.frame.size.height - (frame?.size.height)!
        UIView.animate(withDuration: 0.25, animations: {
            self.tabBarController?.tabBar.frame = frame!
        })
    }
    
    func hideNavBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func showNavBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setNowPlayingLabel() {
        if AppState.currentSong == nil {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    func setNavbarColor() {
        navigationController?.view.backgroundColor = .mainColor
        tabBarController?.view.backgroundColor = .mainColor
    }
    
    func spawnActivityIndicator() -> UIActivityIndicatorView {
        let ai = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        DispatchQueue.main.async {
            ai.backgroundColor = UIColor(white: 0.2, alpha: 0.6)
        }
        ai.layer.frame.size = UIScreen.main.bounds.size
        ai.layer.cornerRadius = 10
        ai.frame = ai.frame.insetBy(dx: -10, dy: -10)

        ai.center = {
            let b = UIScreen.main.bounds
            return CGPoint(x: b.midX, y: b.midY)
        }()
        ai.hidesWhenStopped = true
        self.view.addSubview(ai)
        return ai
    }
}
