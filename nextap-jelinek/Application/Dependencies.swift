//
//  Dependencies.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 09/10/2020.
//

import Foundation

protocol HasUserDefaultsManager {
  var userDefaultsManager: UserDefaultsManager { get }
}

struct Dependencies: HasUserDefaultsManager {
  
  let userDefaultsManager: UserDefaultsManager
}

