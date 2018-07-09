//
//  YouTubeSearchTests.swift
//  YouTubeSearchTests
//
//  Created by Adrián Salazar G on 08/07/18.
//  Copyright © 2018 Adrián Salazar G. All rights reserved.
//

import UIKit
import XCTest
@testable import YouTubeSearch

class YouTubeSearchTests: XCTestCase {
    
    lazy var responseDic:[String:Any]? = {
        let bundle = Bundle(for: type(of: self))
        guard let pathFile = bundle.path(forResource: "Youtube", ofType: "json") else{
            return nil
        }
        do{
            let urlFile = URL(fileURLWithPath: pathFile)
            let data = try Data(contentsOf: urlFile)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            return dictionary
        }catch{
            return nil
        }
    }()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetVideos(){
        guard let response = responseDic, let item = response["items"] as? [[String:Any]] else{
            XCTFail("Error con el json")
            return
        }
        XCTAssert(!VideoModel.getVideosModelWith(arrDic: item).isEmpty)
    }
    
    func testCountArrayVideos(){
        guard let response = responseDic, let item = response["items"] as? [[String:Any]] else{
            XCTFail("Error con el json")
            return
        }
        XCTAssertEqual(VideoModel.getVideosModelWith(arrDic: item).count, 10)
    }
    
}
