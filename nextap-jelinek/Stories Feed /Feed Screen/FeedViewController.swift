//
//  FeedVC.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 09/10/2020.
//

import UIKit

protocol FeedDelegate: class {
  
  func fetchStories(vc: FeedViewController)
}

class FeedViewController: UIViewController {
  
  weak var delegate: FeedDelegate?
  private var displayedStories: [Story] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    delegate?.fetchStories(vc: self)
  }
  
  func showStories(stories: [Story]) {
    
  }
}


