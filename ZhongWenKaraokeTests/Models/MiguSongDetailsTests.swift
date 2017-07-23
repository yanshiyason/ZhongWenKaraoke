//
//  MiguSongDetailsTests.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/21/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import XCTest
import Pantry
@testable import ZhongWenKaraoke

class MiguSongDetailsTests: XCTestCase {
    
    var sut: MiguSongDetails!
    var json: Data!
    
    override func setUp() {
        super.setUp()
        json = JsonFromFixture("songDetails")
        sut = MiguSongDetails(fromJson: json)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_initFromJsonData() {
        XCTAssertNotNil(MiguSongDetails(fromJson: json))
    }
    
    func testPantry_itIsSerializable() {
        XCTAssertNoThrow(Pantry.pack(sut, key: "sut"))
    }
    
    func testPantry_itIsDeserializable() {
        XCTAssertNoThrow(Pantry.pack(sut, key: "sut"))
        let deserializedSut: MiguSongDetails = Pantry.unpack("sut")!
        XCTAssertEqual(deserializedSut.songName, "Praying")
    }
}
