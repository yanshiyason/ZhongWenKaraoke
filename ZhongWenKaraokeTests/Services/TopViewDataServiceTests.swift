//
//  TopViewDataServiceTests.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/22/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import XCTest
@testable import ZhongWenKaraoke

class TopViewDataServiceTests: XCTestCase {
    
    var sut: TopViewDataService!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = TopViewDataService()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_init_migSonguStoreIsNotNull() {
        XCTAssertNotNil(sut.miguSongStore)
    }
    
}
