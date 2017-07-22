//
//  MiguSongCellTests.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/22/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import XCTest
@testable import ZhongWenKaraoke

class MiguSongCellTests: XCTestCase {
    
    var sut: MiguSongCell!
    var tableView: UITableView!
    var dataSource: MockTableViewDataSource!
        
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let topVC = storyboard.instantiateViewController(withIdentifier: "TopViewController") as! TopViewController
        _ = topVC.view
        
        tableView = topVC.songsTable
        dataSource = MockTableViewDataSource()
        tableView.dataSource = dataSource
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConfigWithSong_SetsTheSong() {
        let song = MiguSong(
            artist: "Pockets",
            song: "Show me the money",
            url: "http://music.migu.cn/#/song/1106678347/P1Z1Y1L6N2/7/001002A"
        )
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MiguSongCell") as! MiguSongCell
        cell.config(withSong: song)
        XCTAssertEqual(song, cell.song)
        XCTAssertEqual(cell.textLabel?.text, cell.song.song)
        XCTAssertEqual(cell.detailTextLabel?.text, cell.song.artist)
    }
}

extension MiguSongCellTests {
    class MockTableViewDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
