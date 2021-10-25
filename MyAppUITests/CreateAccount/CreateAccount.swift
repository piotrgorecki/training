//
//  CreateAccount.swift
//  MyAppUITests
//
//  Created by Tomasz Popis on 25/10/2021.
//

import XCTest

class CreateAccount {
  
  class func createAccount(login: String, password: String, confirm: String) {
    enter(login: login)
    enter(password: password)
    enter(confirm: password)
    
    let button = app.buttons[UserInterface.CreateAccount.createAccountButton]
    button.tap()
  }
  
  class func enter(login: String) {
    let field = app.textFields[UserInterface.CreateAccount.loginTextField]
    field.tap()
    field.typeText(login)
  }
  
  class func enter(password: String) {
    let field = app.secureTextFields[UserInterface.CreateAccount.passwordTextField]
    field.tap()
    field.typeText(password)
  }
  
  class func enter(confirm: String) {
    let field = app.secureTextFields[UserInterface.CreateAccount.confirmTextFiled]
    field.tap()
    field.typeText(confirm)
  }
}
