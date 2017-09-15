//
//  CategoryViewControllerTests.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/22/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import ZhongWenKaraoke

class CategoryViewControllerTests: XCTestCase {
    var sut: CategoryViewController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_init_tableViewIsNotNull() {
        XCTAssertNotNil(sut.songsTable)
    }
    
    func testViewDidLoad_SetsTableViewDataSource() {
        XCTAssertNotNil(sut.songsTable.dataSource)
        XCTAssertTrue(sut.songsTable.dataSource is TopViewDataService)
    }
    
    func testViewDidLoad_SetsTableViewDelegate() {
        XCTAssertNotNil(sut.songsTable.delegate)
        XCTAssertTrue(sut.songsTable.delegate is TopViewDataService)
    }
    
    func testViewDidLoad_SetsTableViewDelegateAndDataSourceToSameObject() {
        XCTAssertEqual(sut.songsTable.delegate as! TopViewDataService, sut.songsTable.dataSource as! TopViewDataService)
    }
}
