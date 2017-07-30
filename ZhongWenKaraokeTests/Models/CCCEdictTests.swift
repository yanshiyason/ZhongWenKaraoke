//
//  CCCEdictTests.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/29/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import XCTest
@testable import ZhongWenKaraoke

class CCCEdictTests: XCTestCase {
    
    var songLyrics: MiguSongLyrics!
    
    override class func setUp() {
        _ = CCCEdict.dictionary
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
      // more complex pinyinify function. Tries to maintain spaces.
//    func testPinyinify_itPinyinifiesTextProperly() {
//        XCTAssertEqual(CCCEdict.pinyinify("让他温暖我的双眼"), "ràng tā wēnnuǎn wǒ de shuāngyǎn")
//        XCTAssertEqual(CCCEdict.pinyinify("我受不了了"), "wǒ shòubùliǎo le")
//        XCTAssertEqual(CCCEdict.pinyinify("好"), "hǎo")
//        XCTAssertEqual(CCCEdict.pinyinify("我觉得睡觉是很重要的。我睡了一个好觉有很好的感觉。"), "wǒ juéde shuìjiào shì hěn zhòngyào de。wǒ shuì le yī gè hǎo jiào yǒu hěn hǎo de gǎnjué。")
//        XCTAssertEqual(CCCEdict.pinyinify("他给我发了个短信：“我长大的时候我的头发很长。但是现在我喜欢理发。”"), "tā gěi wǒ fā le gè duǎnxìn：“wǒ zhǎngdà de shíhou wǒ de tóufa hěn cháng。dànshì xiànzài wǒ xǐhuan lǐfà。”")
//        XCTAssertEqual(CCCEdict.pinyinify("我有2个。他有540！50%的意思是百分之五十。"), "wǒ yǒu2gè。tā yǒu540！50%de yìsi shì bǎifēnzhī wǔshí。")
//    }

    // simplified pinyinify function
    func testPinyinify_itPinyinifiesTextProperly() {
        XCTAssertEqual(CCCEdict.pinyinify("让他温暖我的双眼"), "ràng tā wēnnuǎn wǒ de shuāngyǎn ")
        XCTAssertEqual(CCCEdict.pinyinify("我受不了了"), "wǒ shòubùliǎo le ")
        XCTAssertEqual(CCCEdict.pinyinify("好"), "hǎo ")
        XCTAssertEqual(CCCEdict.pinyinify("我觉得睡觉是很重要的。我睡了一个好觉有很好的感觉。"), "wǒ juéde shuìjiào shì hěn zhòngyào de 。wǒ shuì le yī gè hǎo jiào yǒu hěn hǎo de gǎnjué 。")
        XCTAssertEqual(CCCEdict.pinyinify("他给我发了个短信：“我长大的时候我的头发很长。但是现在我喜欢理发。”"), "tā gěi wǒ fā le gè duǎnxìn ：“wǒ zhǎngdà de shíhou wǒ de tóufa hěn cháng 。dànshì xiànzài wǒ xǐhuan lǐfà 。”")
        XCTAssertEqual(CCCEdict.pinyinify("我有2个。他有540！50%的意思是百分之五十。"), "wǒ yǒu 2gè 。tā yǒu 540！50%de yìsi shì bǎifēnzhī wǔshí 。")
    }
    
    func testSimplified_itTranslatesToSimplified() {
        XCTAssertEqual(CCCEdict.simplified("让他温暖我的双眼"), "让他温暖我的双眼")
        XCTAssertEqual(CCCEdict.simplified("我受不了了"), "我受不了了")
        XCTAssertEqual(CCCEdict.simplified("好"), "好")
        XCTAssertEqual(CCCEdict.simplified("我觉得睡觉是很重要的。我睡了一个好觉有很好的感觉。"), "我觉得睡觉是很重要的。我睡了一个好觉有很好的感觉。")
        XCTAssertEqual(CCCEdict.simplified("他给我发了个短信：“我长大的时候我的头发很长。但是现在我喜欢理发。”"), "他给我发了个短信：“我长大的时候我的头发很长。但是现在我喜欢理发。”")
        XCTAssertEqual(CCCEdict.simplified("我有2个。他有540！50%的意思是百分之五十。"), "我有2个。他有540！50%的意思是百分之五十。")
    }
    
    func testTraditional_itTranslatesToTraditional() {
        XCTAssertEqual(CCCEdict.traditional("让他温暖我的双眼"), "讓他溫暖我的雙眼")
        XCTAssertEqual(CCCEdict.traditional("我受不了了"), "我受不了了")
        XCTAssertEqual(CCCEdict.traditional("好"), "好")
        XCTAssertEqual(CCCEdict.traditional("我觉得睡觉是很重要的。我睡了一个好觉有很好的感觉。"), "我覺得睡覺是很重要的。我睡了一個好覺有很好的感覺。")
        XCTAssertEqual(CCCEdict.traditional("他给我发了个短信：“我长大的时候我的头发很长。但是现在我喜欢理发。”"), "他給我發了個短信：“我長大的時候我的頭髮很長。但是現在我喜歡理髮。”")
        XCTAssertEqual(CCCEdict.traditional("我有2个。他有540！50%的意思是百分之五十。"), "我有2個。他有540！50%的意思是百分之五十。")
    }
    
    func testCut_itDoesntBreakWhenGivenEmptyString() {
        XCTAssertNoThrow(CCCEdict.cut(""))
    }
    
    
    
}
