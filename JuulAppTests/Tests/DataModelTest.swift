//
//  DataModelTest.swift
//  DataModelTest
//
//  Created by Denis Kalashnikov on 4/11/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import XCTest
@testable import JuulApp

class DataModelTest: XCTestCase {
    var model : Products?
    override func setUp() {
        if let url = Bundle.main.url(forResource: "model", withExtension: "json"), let jsonData = try? Data(contentsOf: url){
            model = try? JSONDecoder().decode(Products.self, from: jsonData)
        }
    }
    
    override func tearDown() {
        model = nil
    }
    
    func testModelHasLoaded() {
        XCTAssert(model != nil)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testNumbersOfPodsLoaded()  {
        XCTAssert(model?.pods?.count ?? -1 > 0)
    }
}
