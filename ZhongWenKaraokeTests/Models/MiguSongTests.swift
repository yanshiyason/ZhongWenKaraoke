//
//  MiguSongTests.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/21/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation

import XCTest
@testable import ZhongWenKaraoke

class MiguSongTests: XCTestCase {
    var sut: MiguSong!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = MiguSong(
            artist: "Pockets",
            song: "Show me the money",
            url: "http://music.migu.cn/#/song/1106678347/P1Z1Y1L6N2/7/001002A"
        )
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_init_itSetsTheItemIdFromTheUrl() {
        XCTAssertEqual(sut.itemId, "1106678347")
    }

    func test_init_itSetsTheLocFromTheUrl() {
        XCTAssertEqual(sut.loc, "P1Z1Y1L6N2")
    }
    
    func test_init_itSetsTheLocnoFromTheUrl() {
        XCTAssertEqual(sut.locno, "7")
    }
    
    func test_lyricsUrl_ItReturnsTheCorrectUrl() {
        XCTAssertEqual(sut.lyricsUrl, "http://music.migu.cn/webfront/player/lyrics.do?songid=1106678347")
    }
    
    func test_songDetailsUrl_ItReturnsTheCorrectUrl() {
        XCTAssertEqual(
            sut.mp3Url,
            "http://music.migu.cn/webfront/player/findsong.do?itemid=1106678347&type=song&loc=P1Z1Y1L6N2&locno=7"
        )
    }
}
