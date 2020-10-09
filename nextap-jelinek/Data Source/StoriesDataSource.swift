//
//  StoriesDataSource.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 09/10/2020.
//

import Foundation

class StoriesDataSource {
  
  var stories: [Story] = []
  private var request: GetStoriesRequest?
  
  func fetchData(completion: @escaping RequestStoriesCompletion) {
    
    request = GetStoriesRequest()
    request?.send(completion: completion)
  }
}
