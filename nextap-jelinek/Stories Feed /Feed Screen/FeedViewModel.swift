//
//  FeedViewModel.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 09/10/2020.
//

import Foundation
import UIKit

class FeedViewModel {
  
  private let stories: [Story]
  
  init(stories: [Story]) {
    
    self.stories = stories
  }
  
  func stories(inSection section: Int) -> Int {
    return stories.count
  }
  
  func story(atIndexPath indexPath: IndexPath) -> Story? {
    
    guard indexPath.row < stories.count else { return nil }
    return stories[indexPath.row]
  }
}
