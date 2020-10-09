//
//  UserDefaultsManager.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 09/10/2020.
//

import Foundation

class UserDefaultsManager {
  
  private enum UserDefaultsKey: String {
    case username
  }
  
  private let defaultStorage: UserDefaults
  
  init() {
    
    UserDefaults.standard.register(defaults: [String: Any]())
    defaultStorage = UserDefaults.standard
    defaultStorage.synchronize()
  }
  
  func loadUsername() -> String? {
    
    defaultStorage.string(forKey: UserDefaultsKey.username.rawValue)
  }
  
  func saveUsername(username: String?) {
    
    defaultStorage.set(username, forKey: UserDefaultsKey.username.rawValue)
    defaultStorage.synchronize()
  }
}
