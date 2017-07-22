//
//  MiguSongManagerTests.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/21/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import ZhongWenKaraoke

class MiguSongManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        stub(condition: isHost("music.migu.cn") && isPath("/184_11.html")) { request in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("miguTopPage.html", type(of: self))!,
                statusCode: 200,
                headers: [:]
            ).responseTime(0)
        }
        
        OHHTTPStubs.onStubActivation() {request, descriptor, response in
            print("\(String(describing: request.url)) stubbed by \(String(describing: descriptor.name)).")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func testInit_itAssignsMiguSongs() {
        let manager = MiguSongManager()
        let exp = expectation(description: "\(#function)\(#line)")

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            XCTAssertTrue(manager.songs!.count > 0)
            exp.fulfill()
        }
        
        // Wait for the async request to complete
        waitForExpectations(timeout: 3, handler: nil)
    }
    
}
