//
//  MiguSongLyricsTest.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/23/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import XCTest
@testable import ZhongWenKaraoke

class MiguSongLyricsTest: XCTestCase {
    var sut: MiguSongLyrics!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let rawLyrics = JsonFromFixture("lyrics")
        sut = MiguSongLyrics(rawLyrics)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseLyrics_itReturnsLyricLines() {
        XCTAssertTrue(sut.lyrics.count > 0)
    }
    
    func testTimestampToSeconds() {
        XCTAssertEqual(sut.lyrics[3].timestampToSeconds(), Float(1))
        XCTAssertEqual(sut.lyrics[5].timestampToSeconds(), Float(15.66))
    }
    
    func testLineIndexForSeconds() {
        XCTAssertEqual(sut.lineIndex(for: Float(16)), 5)
        XCTAssertEqual(sut.lineIndex(for: Float(239.99)), 49)
    }
    
    func testText_itReturnsLyricsWithoutTimestamps() {
        XCTAssertEqual(sut.lyrics[5].text(), "We were just about to lose our home ")
    }
    
    func testText_itReturnsLyricsWithoutTimestampsWhenChineseLyrics() {
        let s = MiguSongLyrics(JsonFromFixture("lyrics1"))
        XCTAssertEqual(s.lyrics[6].text(), "让他温暖我的双眼")
    }
}
