//
//  MiguDataServiceTests.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/19/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import XCTest
import Mockingjay
@testable import ZhongWenKaraoke

class MiguDataServiceTests: XCTestCase {
    
    var sut: MiguDataService!
    
    func HtmlFixtureURL(_ title: String) -> URL {
        return Bundle(for: type(of: self)).url(forResource: title, withExtension: "html")!
    }
    
    func HtmlFromFixture(_ title: String) -> String {
        let data = try! Data.init(contentsOf: HtmlFixtureURL(title))
        return String(data: data, encoding: .utf8)!
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = MiguDataService()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_InitsWithoutParams() {
        XCTAssertNoThrow(MiguDataService())
    }
    
    func test_parseHomePage_ItCanExtractMiguSongs() {
        let html = HtmlFromFixture("miguTopPage")
        let miguSongs = sut.parseHomePage(html)
        XCTAssertTrue(miguSongs.count == 60)
    }
    
}
