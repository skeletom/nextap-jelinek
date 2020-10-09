//
//  MainScreenCoordinator.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 09/10/2020.
//

import Foundation
import UIKit

class MainScreenCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController
  var dependencies: Dependencies
  
  init(navigationController: UINavigationController, dependencies: Dependencies) {
    
    self.navigationController = navigationController
    self.dependencies = dependencies
  }
  
  func start() {
    
    let mainVC = MainVC()
    navigationController.pushViewController(mainVC, animated: false)
  }
}
