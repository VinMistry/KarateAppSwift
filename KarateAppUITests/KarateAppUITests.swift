//
//  KarateAppUITests.swift
//  KarateAppUITests
//
//  Created by Vinesh Mistry on 07/12/2017.
//  Copyright © 2017 Vinesh Mistry. All rights reserved.
//

import XCTest
import Firebase
class KarateAppUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launchArguments.append("--uitesting")
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWrongPassword() {
        app.launch()
        app.textFields["Email"].tap()
        app.typeText("test55@gmail.com")
        app.secureTextFields["Password"].tap()
        app.typeText("test56")
        app.buttons["Log In"].tap()
        app.swipeLeft()
        //Settings button only appears if the user is logged in
        XCTAssertFalse(app.navigationBars["Home"].buttons["settings"].exists)
        
    }
    
    func testWrongEmail() {
        app.launch()
        app.textFields["Email"].tap()
        app.typeText("cc")
        app.secureTextFields["Password"].tap()
        app.typeText("test56")
        app.buttons["Log In"].tap()
        app.swipeLeft()
        //Settings button only appears if the user is logged in
        XCTAssertFalse(app.navigationBars["Home"].buttons["settings"].exists)
       
    }
    
    func testCorrectPassword() {
        app.launch()
        app.textFields["Email"].tap()
        app.typeText("test55@gmail.com")
        app.secureTextFields["Password"].tap()
        app.typeText("test556")
        app.buttons["Log In"].tap()
        //Settings button only appears if the user is logged in
        XCTAssertTrue(app.navigationBars["Home"].buttons["settings"].waitForExistence(timeout: 100))
    }
    
    func testSignUpCorrectDetails(){
        let testNumber = 21
        app.launch()
        let signUpButton = app.buttons["Sign Up"]
        signUpButton.tap()
        app.textFields["Name"].tap()
        app.typeText("testSignUp")
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        emailTextField.typeText("test\(testNumber)@gmail.com")
        app.secureTextFields["Password"].tap()
       app.secureTextFields["Password"].typeText("test\(testNumber)77")
        signUpButton.tap()
        if(app.pickerWheels["White"].waitForExistence(timeout: 100)){
        app.pickerWheels["White"].press(forDuration: 1.1)
        app.buttons["Finish"].tap()
        XCTAssertTrue(app.navigationBars["Home"].buttons["settings"].waitForExistence(timeout: 100))
        }
        else {
            XCTFail()
            
        }
    }
    func testSignUpIncorrectEmailFormat(){
        let testNumber = 21
        app.launch()
        let signUpButton = app.buttons["Sign Up"]
        signUpButton.tap()
        app.textFields["Name"].tap()
        app.typeText("testSignUp")
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        emailTextField.typeText("test\(testNumber)")
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("test\(testNumber)77")
        signUpButton.tap()
        if(app.pickerWheels["White"].waitForExistence(timeout: 50)){
           XCTFail()
        }
        else {
            XCTAssertFalse(app.pickerWheels["White"].waitForExistence(timeout: 30))
        }
    }
    func testSignUpPasswordLengthTooShort(){
        let testNumber = 21
        app.launch()
        let signUpButton = app.buttons["Sign Up"]
        signUpButton.tap()
        app.textFields["Name"].tap()
        app.typeText("testSignUp")
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        emailTextField.typeText("test\(testNumber)@gmail.com")
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("t")
        signUpButton.tap()
        if(app.pickerWheels["White"].waitForExistence(timeout: 50)){
            XCTFail()
        }
        else {
            XCTAssertFalse(app.pickerWheels["White"].waitForExistence(timeout: 30))
        }
    }
    
    func testLearningGoodMorningDropdown() {
        app.launch()
        app.textFields["Email"].tap()
        app.typeText("test55@gmail.com")
        app.secureTextFields["Password"].tap()
        app.typeText("test556")
        app.buttons["Log In"].tap()
        XCTAssertTrue(app.navigationBars["Home"].buttons["settings"].waitForExistence(timeout: 100))
        app.tabBars.buttons["Learn"].tap()
        let tablesQuery2 = app.tables
        let tablesQuery = tablesQuery2
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Japanese"]/*[[".cells.staticTexts[\"Japanese\"]",".staticTexts[\"Japanese\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Greetings"]/*[[".cells.staticTexts[\"Greetings\"]",".staticTexts[\"Greetings\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let goodMorning = tablesQuery2.children(matching: .other)["Good Morning"].children(matching: .other)["Good Morning"]
        goodMorning.tap()
        XCTAssertTrue( tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Ohayō gozaimasu"]/*[[".cells.staticTexts[\"Ohayō gozaimasu\"]",".staticTexts[\"Ohayō gozaimasu\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 20))
        XCTAssertTrue(tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Hiragana: おはよう　ございます"]/*[[".cells.staticTexts[\"Hiragana: おはよう　ございます\"]",".staticTexts[\"Hiragana: おはよう　ございます\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 20))
        XCTAssertTrue(tablesQuery.staticTexts["Kanji: お早う御座います"].waitForExistence(timeout: 20))
    }
    
    func testViewPost() {
        app.launch()
        app.textFields["Email"].tap()
        app.typeText("test55@gmail.com")
        app.secureTextFields["Password"].tap()
        app.typeText("test556")
        app.buttons["Log In"].tap()
        XCTAssertTrue(app.navigationBars["Home"].buttons["settings"].waitForExistence(timeout: 100))
        app.tabBars.buttons["Updates"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["test for insert "]/*[[".cells.staticTexts[\"test for insert \"]",".staticTexts[\"test for insert \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let updatetextbodyTextView = app.textViews["UpdateTextBody"]
        XCTAssertTrue(updatetextbodyTextView.waitForExistence(timeout: 20))
    }
    
    func testAddPostButtonAppearsForInstructor() {
        app.launch()
        app.textFields["Email"].tap()
        app.typeText("test55@gmail.com")
        app.secureTextFields["Password"].tap()
        app.typeText("test556")
        app.buttons["Log In"].tap()
        XCTAssertTrue(app.navigationBars["Home"].buttons["settings"].waitForExistence(timeout: 100))
        app.tabBars.buttons["Updates"].tap()
        XCTAssertTrue(app.navigationBars["Updates"].buttons["Add Post"].waitForExistence(timeout: 10))
    }
    
    func testAddPostButtonDoesNotAppearForStudent() {
        app.launch()
        app.textFields["Email"].tap()
        app.typeText("test57@gmail.com")
        app.secureTextFields["Password"].tap()
        app.typeText("test5777")
        app.buttons["Log In"].tap()
        XCTAssertTrue(app.navigationBars["Home"].buttons["settings"].waitForExistence(timeout: 100))
        app.tabBars.buttons["Updates"].tap()
        XCTAssertFalse(app.navigationBars["Updates"].buttons["Add Post"].waitForExistence(timeout: 10))
    }
    
    
}
