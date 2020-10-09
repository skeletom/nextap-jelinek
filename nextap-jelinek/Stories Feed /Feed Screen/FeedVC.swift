//
//  FeedVC.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 09/10/2020.
//

import UIKit

protocol FeedDelegate: class {
  
  func fetchStories(vc: FeedVC)
}

class FeedVC: UIViewController {
  
  private weak var delegate: FeedDelegate?
  private var displayedStories: [Story] = []
  
  init(delegate: FeedDelegate?) {
    
    self.delegate = delegate
    super.init(nibName: "Feed", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    delegate?.fetchStories(vc: self)
  }
  
  func showStories(stories: [Story]) {
    
  }
}


