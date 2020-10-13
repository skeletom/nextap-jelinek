//
//  FeedVC.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 09/10/2020.
//

import UIKit

protocol FeedDelegate: class {
  
  func fetchStories(vc: FeedViewController)
  func changeFeedType(vc: FeedViewController, feedType: UICollectionView.ScrollDirection, showStory story: Story)
}

class FeedViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  weak var delegate: FeedDelegate?
  private var viewModel: FeedViewModel?
  private var feedDirection: UICollectionView.ScrollDirection {
    return (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationBar()
    delegate?.fetchStories(vc: self)
  }
  
  // MARK: - Reload Data
  
  func reloadStories(stories: [Story]) {
    
    viewModel = FeedViewModel(stories: stories)
    
    if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      layout.itemSize = sizeForItem(withFlowLayout: layout)
    }
    
    collectionView.reloadData()
  }
  
  // MARK: - Change Feed Style
  
  func changeFeedType(newDirection: UICollectionView.ScrollDirection, showStory story: Story) {
    
    guard let indexPath = viewModel?.indexPath(forStory: story) else { return }
    
    switch newDirection {
    case .horizontal:
      changeToHorizontalFeedType(showStoryAtIndexPath: indexPath)
    case .vertical:
      changeToVerticalFeedType(showStoryAtIndexPath: indexPath)
    @unknown default:()
    }
    
    setupNavigationBar()
  }
  
  private func changeToHorizontalFeedType(showStoryAtIndexPath indexPath: IndexPath) {
    
    UIView.animate(withDuration: 0.5) {[self] in
      
      let horizontalLayout = HorizontalFlowLayout()
      let itemSize = sizeForItem(withFlowLayout: horizontalLayout)
      horizontalLayout.itemSize = itemSize
      
      collectionView.collectionViewLayout = horizontalLayout
      collectionView.decelerationRate = .fast
      
      collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
  }
  
  private func changeToVerticalFeedType(showStoryAtIndexPath indexPath: IndexPath) {
    
    UIView.animate(withDuration: 0.5) {[self] in
      
      if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
        
        layout.scrollDirection = .vertical
        layout.itemSize = sizeForItem(withFlowLayout: layout)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
      }
    }
  }
  
  private func sizeForItem(withFlowLayout flowayout: UICollectionViewFlowLayout) -> CGSize {
    
    let space: CGFloat = (flowayout.minimumInteritemSpacing) + (flowayout.sectionInset.left) + (flowayout.sectionInset.right)
    var itemSize: CGSize
    
    switch flowayout.scrollDirection {
    case .vertical:
      let width: CGFloat = (collectionView.frame.size.width - space) / 2.0
      let height: CGFloat = width * (16 / 9)
      itemSize = CGSize(width: width, height: height)
    case .horizontal:
      let width: CGFloat = (collectionView.frame.size.width - space) * 0.9
      let height: CGFloat = width * (16 / 9)
      itemSize = CGSize(width: width, height: height)
    @unknown default:
      return CGSize.zero
    }
    
    return itemSize
  }
  
  // MARK: - Navigation Bar
  
  private func setupNavigationBar() {
    
    title = NSLocalizedString("stories.title", comment: "")
    
    switch feedDirection {
    case .vertical:
      let feedToHorizontalBarButton = UIBarButtonItem(image: UIImage(systemName: "doc.richtext") , style: .plain, target: self, action: #selector(feedToHorizontalBarButtonTapped))
      feedToHorizontalBarButton.tintColor = UIColor.black
      navigationItem.rightBarButtonItem = feedToHorizontalBarButton
    case .horizontal:
      let feedToVerticalBarButton = UIBarButtonItem(image: UIImage(systemName: "square.grid.3x3.fill.square") , style: .plain, target: self, action: #selector(feedToVerticalBarButtonTapped))
      feedToVerticalBarButton.tintColor = UIColor.black
      navigationItem.rightBarButtonItem = feedToVerticalBarButton
    @unknown default:()
    }
  }
  
  @objc func feedToHorizontalBarButtonTapped() {
    
    guard let story = currentStory() else { return }
    delegate?.changeFeedType(vc: self, feedType: .horizontal, showStory: story)
  }
  
  @objc func feedToVerticalBarButtonTapped() {
    
    guard let story = currentStory() else { return }
    delegate?.changeFeedType(vc: self, feedType: .vertical, showStory: story)
  }
  
  private func currentStory() -> Story? {
    
    guard let firstVisibleCell =  collectionView.visibleCells.first, let indexPath = collectionView.indexPath(for: firstVisibleCell), let story = viewModel?.story(atIndexPath: indexPath) else { return nil }
    return story
  }
}

extension FeedViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.stories(inSection: section) ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let viewModel = viewModel, let story = viewModel.story(atIndexPath: indexPath) else { return UICollectionViewCell() }
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCellIdentifier", for: indexPath) as! FeedCell
    cell.setup(withStory: story, feedDirection: feedDirection)
    return cell
  }
}

extension FeedViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    guard feedDirection == .vertical, let story = viewModel?.story(atIndexPath: indexPath) else { return }
    delegate?.changeFeedType(vc: self, feedType: .horizontal, showStory: story)
  }
}

