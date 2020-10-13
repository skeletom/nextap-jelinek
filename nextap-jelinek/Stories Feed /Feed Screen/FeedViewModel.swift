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
  
  func indexPath(forStory story: Story) -> IndexPath? {
    
    guard let index = stories.firstIndex(of: story) else { return nil }
    return IndexPath(item: index, section: 0)
  }
}
