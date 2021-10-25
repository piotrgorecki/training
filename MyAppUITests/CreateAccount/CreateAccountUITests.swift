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
    CreateAccount.enter(login: "aaa")
    
    CreateAccountAssert.loginValidatorMessage(enabled: true)
    CreateAccountAssert.passwordValidatorMessage(enabled: false)
    CreateAccountAssert.createAccountAction(enabled: false)
  }
  
  func testCreateAccountWithInvalidLogin() throws {
    CreateAccount.enter(login: "aaa")
    
    CreateAccountAssert.loginValidatorMessage(enabled: true)
    CreateAccountAssert.passwordValidatorMessage(enabled: false)
    CreateAccountAssert.createAccountAction(enabled: false)
  }
  
  func testCreateAccountWithInvalidPassword() throws {
    CreateAccount.enter(password: "sfd")
    
    CreateAccountAssert.loginValidatorMessage(enabled: false)
    CreateAccountAssert.passwordValidatorMessage(enabled: true)
    CreateAccountAssert.createAccountAction(enabled: false)
  }
  
  func testCreateAccountWithInvalidAllData() throws {
    CreateAccount.enter(login: "aaaa")
    CreateAccount.enter(password: "A")
    CreateAccount.enter(confirm: "Aa!1a")
    
    CreateAccountAssert.loginValidatorMessage(enabled: true)
    CreateAccountAssert.passwordValidatorMessage(enabled: true)
    CreateAccountAssert.createAccountAction(enabled: false)
  }
  
  func testCreateAccountWithNoConfirm() throws {
    CreateAccount.enter(login: "aaaaaaaa")
    CreateAccount.enter(password: "Aa!1aaaa")
    
    CreateAccountAssert.loginValidatorMessage(enabled: false)
    CreateAccountAssert.passwordValidatorMessage(enabled: true)
    CreateAccountAssert.createAccountAction(enabled: false)
  }
  
  func testCreateAccountWithCorrectData() throws {
    CreateAccount.enter(login: "asdfghjk")
    CreateAccount.enter(password: "Aa!1aaaa")
    CreateAccount.enter(confirm: "Aa!1aaaa")
    
    CreateAccountAssert.loginValidatorMessage(enabled: false)
    CreateAccountAssert.passwordValidatorMessage(enabled: false)
    CreateAccountAssert.createAccountAction(enabled: true)
  }
  
  
  
  func testExample() throws {
  }
}
