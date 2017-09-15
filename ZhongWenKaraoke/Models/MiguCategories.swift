//
//  MiguParentCategory.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/31/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation

struct MiguParentCategory {
    let chinese: String
    let english: String
    let categories: [MiguCategory]
}

struct MiguCategory {
    let chinese: String
    let english: String
    let url: String
}
