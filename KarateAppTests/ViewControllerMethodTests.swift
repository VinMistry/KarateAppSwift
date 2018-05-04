//
//  ViewControllerMethodTests.swift
//  KarateAppTests
//
//  Created by Vinesh Mistry on 02/05/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import XCTest
import Firebase
@testable import KarateApp

class ViewControllerMethodTests: XCTestCase {
    
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

    
    //Tests the performance of retrieving the posts, adding them to an array and then reversing the array.
    func testPerformanceGetPostsAndAddToArray() {
        self.measure {
            // Put the code you want to measure the time of here.
            //Retrieve data from database
            Database.database().reference().child("Posts").observeSingleEvent(of: .value) { (newSnap) in
                print(newSnap)
                for child in newSnap.children {
                    let snap = child as? DataSnapshot
                    guard let post = UpdateModel(snap!) else { print("No Snap"); return}
                    //Add to posts array
                    self.postCollection.append(post)
                }
                //reverse array for displaying
                for post in self.postCollection.reversed() {
                    self.reversedArr.append(post)
                }
            }
        }
        
    }
    
}
