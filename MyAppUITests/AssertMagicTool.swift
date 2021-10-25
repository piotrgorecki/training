//
//  AssertMagicTool.swift
//  MyAppUITests
//
//  Created by Tomasz Popis on 25/10/2021.
//

import XCTest


class AssertMagicTool {
  
  class func labelExist(label: String) {
    XCTAssertTrue(app.staticTexts[label].waitForExistence(timeout: 4.0), "")
  }
}
