//
//  MiguDataServiceTests.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/19/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import XCTest
@testable import ZhongWenKaraoke

class MiguDataServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_InitsWithoutParams() {
        let miguDS = MiguDataService()
        XCTAssertNotNil(miguDS)
    }
    
}
