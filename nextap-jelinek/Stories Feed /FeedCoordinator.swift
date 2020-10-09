//
//  MainScreenCoordinator.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 09/10/2020.
//

import Foundation
import UIKit
import Resolver

class FeedCoordinator: Coordinator {
  
  @Injected var dataSource: StoriesDataSource
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    
    self.navigationController = navigationController
  }
  
  func start() {
    
    guard let feedVC = UIStoryboard(name: "Feed", bundle: nil).instantiateInitialViewController() as? FeedViewController else { return }
    feedVC.delegate = self
    navigationController.pushViewController(feedVC, animated: false)
  }
}

extension FeedCoordinator: FeedDelegate {
  
  func fetchStories(vc: FeedViewController) {
    
    dataSource.fetchData {(result) in
      
      DispatchQueue.main.async {[self] in
        switch result {
        case .success(let stories):
          vc.showStories(stories: stories)
        case .failure(let error):
          alertFetchStoriesFailed(error: error)
        }
      }
    }
  }
  
  private func alertFetchStoriesFailed(error: NetworkingError) {
    
  }
}
