//
//  MyAppApp.swift
//  MyApp
//
//

import SwiftUI

@main
struct MyAppApp: App {
  
  var body: some Scene {
    WindowGroup {
      NavigationView {
        CreateAccountView(model: AccountManager.shared.createAccountModel)
      }
    }
  }
}
