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
  
  func testCreateAccountWithEmptyForm() throws {
    
  }
  
  func testCreateAccountWithInvalidLogin() throws {
    
  }
  
  func testCreateAccountWithInvalidPassword() throws {
    
  }
  
  func testCreateAccountWithNoConfirm() throws {
    
  }
  
  func testCreateAccountWithCorrectData() throws {
    CreateAccount.createAccount(login: "asdfghjk",
                                password: "Aa!1aaaa",
                                confirm: "Aa!1aaaa")
  }
  
  
  
  func testExample() throws {
  }
}
