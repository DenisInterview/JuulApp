//
//  DatabaseTest.swift
//  JuulAppTests
//
//  Created by Denis Kalashnikov on 4/11/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import XCTest
import RealmSwift
@testable import JuulApp

class DatabaseTest: XCTestCase {
    var pod : PodObject?
    var realm : Realm?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        realm = try! Realm()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        if let pod = pod {
            if let realm = realm{
                try! realm.write {
                    realm.delete(pod)
                    print("Delete object")
                }
            }
        }
    }

    func testAddObject() {
        pod = PodObject()
        if let pod = pod {
            pod.id = "1000"
            pod.name = "mango"
            pod.poddescription = "Ripe mango with hints of tropical fruit."
            pod.price = 299
            pod.thumbnailURL = "https://s3.us-east-2.amazonaws.com/juul-coding-challenge/images/mango_thumbnail.png"
            pod.imageURL = "https://s3.us-east-2.amazonaws.com/juul-coding-challenge/images/mango_hires.png"
            
            if let realm = realm{
                try! realm.write {
                    realm.add(pod)
                }
            }
            if let realm = realm{
                let scope = realm.objects(PodObject.self).filter("id == %@", "1000")
                XCTAssert(scope.count == 1)
            }
        }
    }
    
    func testNumbersOfPodsLoaded()  {
        if let realm = realm{
            let pods = realm.objects(PodObject.self)
            XCTAssert(pods.count > 1)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
