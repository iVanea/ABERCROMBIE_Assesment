//
//  AandF_CodeTestTests.swift
//  AandF_CodeTestTests
//
//  Created by Timotin Ion on 3/20/19.
//  Copyright © 2019 Timotin. All rights reserved.
//
import Foundation
import XCTest
@testable import AandF_CodeTest

class AandF_CodeTestTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_start_tableView_withoutData() {
        
    }
    
    func test_init_AllFieldsAreFilled(){
        let json : [String:Any] =  oneJsonProduct
        let sut = try? Product(json:json)
        
        XCTAssertEqual(sut?.title!, "t")
        XCTAssertEqual(sut?.bottomDescription!, "b")
        XCTAssertEqual(sut?.topDescription!, "t")
        XCTAssertEqual(sut?.promoMessage!, "p")
        XCTAssertEqual(sut?.backgroundImage!, "b")
        XCTAssertEqual(sut?.content[0].title, "t")
        XCTAssertEqual(sut?.content[0].target, "t")
        XCTAssertEqual(sut?.content[1].title, "t")
        XCTAssertEqual(sut?.content[1].target, "t")
    }
    
    func test_init_CorrectNumberOfContentOfTwo(){
        let json : [String:Any] = oneJsonProduct
        let sut = try? Product(json:json)
        
        XCTAssertEqual(sut?.content.count, 2)
    }
    
    func test_init_CorrectNumberOfContentOfOne(){
        let json : [String:Any] = leftShopNowButtonInJsonBody(oneJsonProduct)
        
        let sut = try? Product(json:json)
        //contains one button with title and target
        XCTAssertEqual(sut?.content.count, 1)
        XCTAssertEqual(sut?.content[0].title, "t")
        XCTAssertEqual(sut?.content[0].target, "t")
    }
    
    
    func test_init_CorrectEmptyJson(){
        let json : [String:Any] = [:]//empty json
        let sut = try? Product(json:json)
        //everythin is nil, that is ok, because when we got nil, our element will be not displayed in CellView
        XCTAssertEqual(sut?.backgroundImage, nil)
        XCTAssertEqual(sut?.title!, nil)
        XCTAssertEqual(sut?.bottomDescription!, nil)
        XCTAssertEqual(sut?.topDescription!, nil)
        XCTAssertEqual(sut?.promoMessage!, nil)
        XCTAssertEqual(sut?.content[0].title, nil)
        XCTAssertEqual(sut?.content[0].target,nil)

    }

    let oneJsonProduct = ["title":"t","bottomDescription":"b","topDescription":"t", "promoMessage":"p", "backgroundImage":"b","content":[["title":"t","target":"t"],["title":"t","target":"t"]]] as [String : Any]
    
    func leftShopNowButtonInJsonBody(_ json:[String: Any]) -> [String:Any] {
        let content = [["title":"t","target":"t"]]
        var localJson = json
        localJson["content"] = content
        return localJson
    }
    
    //https://medium.com/@johnsundell/unit-testing-asynchronous-swift-code-9805d1d0ac5e
//    func test_viewDidLoad_processProduct(){
//        let product = try? Product(json: oneJsonProduct)
//        let sut = AandFViewController(product: product!)
//        _ = sut.view
//        XCTAssertEqual(sut.productItems[0].title!, "t")
//    }
    
    func test_controllerHaveTableView(){
        guard let controller = UIStoryboard(name: "Main", bundle: Bundle(for: AandFViewController.self)).instantiateInitialViewController() as! UINavigationController? else {
            return XCTFail("Could not instantiate UIViewController from main storyboard")
        }
        
        controller.loadViewIfNeeded()
        
        XCTAssertNotNil(controller.view, "Controller should have a view")
    }
    
}
