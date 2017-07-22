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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseLyrics_itReturnsLyricLines() {
        let rawLyrics = JsonFromFixture("lyrics")
        let lyrics = MiguSongLyrics(rawLyrics)
        
        XCTAssertTrue(lyrics.lyrics.count > 0)
    }
}
