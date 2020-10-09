//
//  AppCoordinator.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 09/10/2020.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController
  var dependencies: Dependencies
  
  init(navigationController: UINavigationController, dependencies: Dependencies) {
    
    self.navigationController = navigationController
    self.dependencies = dependencies
  }
  
  func start() {
    
    presentLoginScreen()
  }
  
  private func presentLoginScreen() {
    
    let mainCoordinator = MainScreenCoordinator(navigationController: navigationController, dependencies: dependencies)
    childCoordinators.append(mainCoordinator)
    mainCoordinator.start()
  }
}
