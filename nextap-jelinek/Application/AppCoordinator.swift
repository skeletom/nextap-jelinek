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
  
  init(navigationController: UINavigationController) {
    
    self.navigationController = navigationController
  }
  
  func start() {
    
    
    presentFeedScreen()
  }
  
  private func presentFeedScreen() {
    
    let feedCoordinator = FeedCoordinator(navigationController: navigationController)
    childCoordinators.append(feedCoordinator)
    feedCoordinator.start()
  }
}
