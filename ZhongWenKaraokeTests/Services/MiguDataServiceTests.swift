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
        XCTAssertEqual(miguSongs.count, 60)
    }
    
    func test_parseSongJson_ItCanExtractTheLyrics() {
        let json = JsonFromFixture("songPage")
        let lyrics = sut.parseLyricsPage(json)
        XCTAssertEqual(lyrics.characters.count, 1600)
    }
    
    func test_homePageUrl_ItReturnsTheCorrectUrl() {
        XCTAssertEqual(sut.homePageUrl, "http://music.migu.cn/184_11.html")
    }
    
}
