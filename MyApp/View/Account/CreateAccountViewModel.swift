//
//  CreateAccountViewModel.swift
//  MyApp
//
//  Created by Tomasz Popis on 23/10/2021.
//

import Foundation
import Combine

enum LoginValidatorState {
  case tooShort
  case valid
}

enum PasswordValidatorState: Int {
  case invalidLength
  case weakPassword
  case noMatch
  case valid
}

protocol CreateAccountViewModelProtocol: ObservableObject {
  var login: String { get set }
  var password: String { get set }
  var confirmPassword: String { get set }
  
  var formIsValid: Bool { get set }
  var loginIsValid: Bool { get set }
  var passwordIsValid: Bool { get set }
  
  var loginIsEditing: Bool { get set }
  var passwordIsEditing: Bool { get set }
  
  var loginValidatorMessage: String { get set }
  var passwordValidatorMessage: String { get set }
  
}

class CreateAccountViewModel: CreateAccountViewModelProtocol {
  
  @Published var login: String
  @Published var password: String
  @Published var confirmPassword: String
  
  @Published var formIsValid: Bool
  @Published var loginIsValid: Bool
  @Published var passwordIsValid: Bool
  
  @Published var loginIsEditing: Bool
  @Published var passwordIsEditing: Bool
  
  @Published var loginValidatorMessage: String
  @Published var passwordValidatorMessage: String
  
  var passwordLengthValidatorPublisher: AnyPublisher<Bool, Never>?
  var strongPasswordValidatorPublisher: AnyPublisher<Bool, Never>?
  var matchingPasswordsValidatorPublisher: AnyPublisher<Bool, Never>?
  
  var loginValidatorPublisher: AnyPublisher<LoginValidatorState, Never>?
  var passwordValidatorPublisher: AnyPublisher<Set<PasswordValidatorState>, Never>?
  var formValidatorPublisher: AnyPublisher<Bool, Never>?
  
  private var validator: AccountValidator
  
  init(validator: AccountValidator) {
    self.login = ""
    self.password = ""
    self.confirmPassword = ""
    
    self.formIsValid = false
    self.loginIsValid = false
    self.passwordIsValid = false
    
    self.loginIsEditing = false
    self.passwordIsEditing = false
    
    self.loginValidatorMessage = ""
    self.passwordValidatorMessage = ""
    
    self.validator = validator
    
    self.preparePublishers()
  }
  
  //MARK: - Publishers
  func preparePublishers() {
    
    self.loginValidatorPublisher = self.$login
      .map { login in self.validator.validate(login: login) }
      .eraseToAnyPublisher()
    
    self.passwordLengthValidatorPublisher = self.$password
      .map { [weak self] password in self?.validator.validateLength(password: password) ?? false }
      .eraseToAnyPublisher()
    
    self.strongPasswordValidatorPublisher = self.$password
      .map { [weak self] password in self?.validator.validateStrong(password: password) ?? false }
      .eraseToAnyPublisher()
    
    self.matchingPasswordsValidatorPublisher = Publishers.CombineLatest($password, $confirmPassword)
      .map { [weak self] password, confirmed in self?.validator.validateMatch(password: password, confirmed: confirmed) ?? false }
      .eraseToAnyPublisher()
    
    self.passwordValidatorPublisher = Publishers.CombineLatest3(self.passwordLengthValidatorPublisher!,
                                                                self.strongPasswordValidatorPublisher!,
                                                                self.matchingPasswordsValidatorPublisher!)
      .map { length, strong, match in
        self.validator.validatePassword(state: (length, strong, match))
      }
      .eraseToAnyPublisher()
    
    self.formValidatorPublisher = Publishers.CombineLatest(self.loginValidatorPublisher!,
                                                           self.passwordValidatorPublisher!)
      
      .map { login, password in (login == .valid) && (password.contains(.valid) ) }
      .eraseToAnyPublisher()
    
    
    self.loginValidatorPublisher?
      .receive(on: DispatchQueue.main)
      .map { login in self.validator.composeValidatorMessage(state: login) }
      .assign(to: &self.$loginValidatorMessage)
    
    self.loginValidatorPublisher?
      .receive(on: DispatchQueue.main)
      .map { state in state == .tooShort && self.login.count > 0 }
      .assign(to: &self.$loginIsEditing)
    
    self.passwordValidatorPublisher?
      .receive(on: DispatchQueue.main)
      .map { data in data.contains(.valid) == false && self.password.count > 0 }
      .assign(to: &self.$passwordIsEditing)
    
    self.passwordValidatorPublisher?
      .receive(on: DispatchQueue.main)
      .map { state in self.validator.composeValidatorMessage(state: state) }
      .assign(to: &self.$passwordValidatorMessage)
    
    self.formValidatorPublisher?
      .receive(on: DispatchQueue.main)
      .assign(to: &self.$formIsValid)
  }
}
