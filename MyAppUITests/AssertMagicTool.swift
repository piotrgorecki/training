//
//  AssertMagicTool.swift
//  MyAppUITests
//
//  Created by Tomasz Popis on 25/10/2021.
//

import XCTest

let notExpectedEnding = " is NOT expected"
let notFoundEnding = " NOT found"
let notAbsentEnding = "NOT absent"

let labelNotFound = " label" + notFoundEnding
let labelNotAbsent = " label" + notAbsentEnding
let textFieldNotFound = "text field " + notFoundEnding

func labelNotFound(label: String) -> String {
  label + notFoundEnding
}

let createAccountActionAccess = " access to the create account action " + notExpectedEnding

class AssertMagicTool {
  
  class func labelExist(label: String) {
    XCTAssertTrue(app.staticTexts[label].waitForExistence(timeout: minTimeout), labelNotFound(label: label) )
  }
  
  class func labelAbsent(label: String) {
    XCTAssertFalse(app.staticTexts[label].waitForExistence(timeout: minTimeout), "")
  }
}
