//
//  IndexPath+Extensions.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 9/17/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation

extension IndexPath {
    func next() -> IndexPath {
        return IndexPath(row: self.row + 1, section: self.section)
    }
    
    func previous() -> IndexPath? {
        guard row > 0 else { return nil }
        return IndexPath(row: row - 1, section: section)
    }
}
