//
//  AccountManager.swift
//  MyApp
//
//

import Foundation

class AccountManager {
  
  public static let shared = AccountManager()
  
  private var _createAccountModel = CreateAccountViewModel(validator: AccountValidator())

  public var createAccountModel: some CreateAccountViewModelProtocol { self._createAccountModel }
  
  private init() { }

}
