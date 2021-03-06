//
//  ContentView.swift
//  MyApp
//
//  Created by Tomasz Popis on 20/10/2021.
//

import SwiftUI

struct CreateAccountView<T>: View where T: CreateAccountViewModelProtocol {
  
  @ObservedObject var model: T
  
  @State var canNavigate = false
  
  var body: some View {
    VStack(spacing: 24) {
        TextField("Login", text: self.$model.login)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        if self.model.loginIsEditing {
          Text(self.model.loginValidatorMessage)
            .foregroundColor(.red)
        }
      
        SecureField("Password", text: self.$model.password)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        SecureField("Confirm password", text: self.$model.confirmPassword)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        if self.model.passwordIsEditing {
          Text(self.model.passwordValidatorMessage)
            .foregroundColor(.red)
        }
      
      NavigationLink(destination: MainView(), isActive: self.$canNavigate) {
        Button(action: self.goToMainView) {
          Text("Create account")
            .padding(8)
            .cornerRadius(10)
        }
      }
      .disabled(!self.model.formIsValid)
    }
    .padding(.horizontal, 24)
  }
  
  func goToMainView() {
    self.canNavigate = true
  }
}

struct MainView: View {
  
  var body: some View {
    Text("ok")
  }
}
