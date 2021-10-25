//
//  MyAppUITests.swift
//  MyAppUITests
//
//  Created by Tomasz Popis on 25/10/2021.
//

import XCTest

class CreateAccountUITests: XCTestCase {
  
  override class func setUp() {
    app.launch()
  }
  
  override func setUpWithError() throws {
    continueAfterFailure = false
  }
  
  override func tearDownWithError() throws {
  }
  
  func testCreateAccountWithEmptyForm() {
    
  }
  
  
  
  func testExample() throws {
    let app = XCUIApplication()
    app.launch()
  }
}
