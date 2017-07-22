//
//  MiguSongStoreTests.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/21/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import ZhongWenKaraoke

class MiguSongStoreTests: XCTestCase {
    
    var sut: MiguSongStore!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = MiguSongStore()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_itAssignsMiguSongs() {
        let exp = expectation(description: "\(#function)\(#line)")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            XCTAssertTrue(self.sut.songs!.count > 0)
            exp.fulfill()
        }
        
        // Wait for the async request to complete
        waitForExpectations(timeout: 3, handler: nil)
    }
}
