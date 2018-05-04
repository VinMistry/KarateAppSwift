//
//  DateModelTests.swift
//  KarateAppTests
//
//  Created by Vinesh Mistry on 02/05/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import XCTest
@testable import KarateApp
class DateModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNextClassDate() {
        let nextClass = GetTheDate().nextClassDate()
        /* Uncomment the expected result and comment out any other expected results */
        
        let str = "Friday at 6:45pm"
        // let str = "Tuesday at 6:30pm"
        
        //If running test on a Tuesday uncomment line below and comment other str
        // let str = "Today at 6:30pm"
        //If running test on a Friday uncomment line below and comment other str
        //let str = "Today at 6:45pm"
        
        XCTAssertEqual(nextClass, str)
    }
    
    func testGetFutureDate() {
        let dateModel = GetTheDate()
        /*Enter the amount of days you wish to add to today's date e.g. If today = 1-5-2018 then
        adding 10 days will = 11-5-2018*/
        let futureDate = dateModel.getFutureDate(addDays: 10)
        //Change date "11-5-2018" to the expected date
        XCTAssertEqual(futureDate, "12-5-2018")
    }
    
    
}
