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
  
  private func alertFetchStoriesFailed(vc: FeedViewController, error: NetworkingError) {
    
    let message: String
    switch error {
    case .unexpected:
      message = NSLocalizedString("fetch.stories.failed.message.unexpected", comment: "")
    case .timeout:
      message = NSLocalizedString("fetch.stories.failed.message.timeout", comment: "")
    }
    
    let alert = UIAlertController(title: NSLocalizedString("fetch.stories.failed.title", comment: ""), message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: NSLocalizedString("fetch.stories.failed.close", comment: ""), style: .cancel, handler: nil))
    
    if error == .timeout {
      alert.addAction(UIAlertAction(title: NSLocalizedString("fetch.stories.failed.retry", comment: ""), style: .default, handler: {[self] (action) in
        fetchStories(vc: vc)
      }))
    }
    
    vc.present(alert, animated: true)
  }
}

extension FeedCoordinator: FeedDelegate {
  
  func fetchStories(vc: FeedViewController) {
    
    dataSource.fetchData {(result) in
      
      DispatchQueue.main.async {[self] in
        switch result {
        case .success(let stories):
          vc.reloadStories(stories: stories)
        case .failure(let error):
          alertFetchStoriesFailed(vc: vc, error: error)
        }
      }
    }
  }
  
  func changeFeedType(vc: FeedViewController, feedType: UICollectionView.ScrollDirection, showStory story: Story) {
    
    vc.changeFeedType(newDirection: feedType, showStory: story)
  }
}
