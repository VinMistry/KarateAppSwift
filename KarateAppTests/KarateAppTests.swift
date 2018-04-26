//
//  KarateAppTests.swift
//  KarateAppTests
//
//  Created by Vinesh Mistry on 07/12/2017.
//  Copyright © 2017 Vinesh Mistry. All rights reserved.
//

import XCTest
@testable import KarateApp
import Firebase
class KarateAppTests: XCTestCase {
    
    private var postCollection = [UpdateModel]()
    private var reversedArr = [UpdateModel]()
    private var post = UpdateModel()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testNextClassDate() {
        let nextClass = GetTheDate().nextClassDate()
        let str = "Friday at 6:45pm"
        XCTAssertEqual(nextClass, str)
    }
    
    func testUpdateModelParameterInit1(){
        let uM = UpdateModel("hello","hello2","hello3")
        XCTAssertEqual(uM.updateTitle, "hello")
    }
    
    func testUpdateModelParameterInit2(){
        let uM = UpdateModel("hello","hello2","hello3")
        XCTAssertEqual(uM.updateText, "hello2")
    }
    
    func testUpdateParameterInit3(){
        let uM = UpdateModel("hello","hello2","hello3")
        XCTAssertEqual(uM.updateDate, "hello3")
    }
    
    
    func testPerformanceGetPostsAndAddToArray() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            Database.database().reference().child("Posts").observeSingleEvent(of: .value) { (newSnap) in
                print(newSnap)
                for child in newSnap.children {
                    let snap = child as? DataSnapshot
                    guard let post = UpdateModel(snap!) else { print("No Snap"); return}
                    self.postCollection.append(post)
                }
                for post in self.postCollection.reversed() {
                    self.reversedArr.append(post)
                }
            }
        }
        
    }
}
