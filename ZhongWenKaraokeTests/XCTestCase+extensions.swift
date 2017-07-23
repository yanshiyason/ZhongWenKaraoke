//
//  XCTestCase+extensions.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/21/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import Foundation
import OHHTTPStubs
import XCTest
import Pantry

extension XCTestCase {
    func HtmlFixtureURL(_ title: String) -> URL {
        return Bundle(for: type(of: self)).url(forResource: title, withExtension: "html")!
    }
    
    func JsonFixtureURL(_ title: String) -> URL {
        return Bundle(for: type(of: self)).url(forResource: title, withExtension: "json")!
    }
    
    func HtmlFromFixture(_ title: String) -> String {
        let data = try! Data.init(contentsOf: HtmlFixtureURL(title))
        return String(data: data, encoding: .utf8)!
    }
    
    func JsonFromFixture(_ title: String) -> Data {
        return try! Data.init(contentsOf: JsonFixtureURL(title))
    }
    
    func stubHomePage(responseTime: Double) {
        stub(condition: isHost("music.migu.cn") && isPath("/184_11.html")) { request in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("miguTopPage.html", type(of: self))!,
                statusCode: 200,
                headers: [:]
            ).responseTime(responseTime)
        }.name = "Home Page Stub"
    }
    
    func stub70sGenreIndex(responseTime: Double) {
        stub(condition: isHost("music.migu.cn") && isPath("/tag/1000587717/P2Z1Y1L2N1/1/001002A")) { request in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("genre_index_70s.html", type(of: self))!,
                statusCode: 200,
                headers: [:]
                ).responseTime(responseTime)
            }.name = "70s index Stub"
    }
    
    func stubSongDetailsPage(responseTime: Double) {
        // "/webfront/player/findsong.do?itemid=\(itemId)&type=song&loc=\(loc)&locno=\(locno)"
        stub(condition: isHost("music.migu.cn") && isPath("/webfront/player/findsong.do")) { request in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("songDetails.json", type(of: self))!,
                statusCode: 200,
                headers: [:]
                ).responseTime(responseTime)
            }.name = "Song details page Stub"
    }
    
    override open func setUp() {
        stubHomePage(responseTime: 0.1)
        stub70sGenreIndex(responseTime: 0.1)
        stubSongDetailsPage(responseTime: 0.1)

        OHHTTPStubs.onStubActivation() {request, descriptor, response in
            print("\n\n\n")
            print(String(repeatElement("#", count: 50)))
            print("\(request.url!) stubbed by \(descriptor.name!).")
            print(String(repeatElement("#", count: 50)))
            print("\n\n\n")
        }
        
        Pantry.removeAllCache()
        super.setUp()
    }
    
    override open func tearDown() {
        OHHTTPStubs.removeAllStubs()
        
        Pantry.removeAllCache()
        super.tearDown()
    }
}
