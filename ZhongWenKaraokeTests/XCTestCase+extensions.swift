//
//  XCTestCase+extensions.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/21/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    func HtmlFixtureURL(_ title: String) -> URL {
        return Bundle(for: type(of: self)).url(forResource: title, withExtension: "html")!
    }
    
    func JsonFixtureURL(_ title: String) -> URL {
        return Bundle(for: type(of: self)).url(forResource: title, withExtension: "json")!
    }
    
    func HtmlFromFixture(_ title: String) -> String {
        let data = try! Data.init(contentsOf: HtmlFixtureURL(title))
        return String(data: data, encoding: .utf8)!
    }
    
    func JsonFromFixture(_ title: String) -> Data {
        return try! Data.init(contentsOf: JsonFixtureURL(title))
    }
}
