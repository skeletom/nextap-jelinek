//
//  FeedVC.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 09/10/2020.
//

import UIKit

protocol FeedDelegate: class {
  
  func fetchStories(vc: FeedViewController)
  func showPreview(vc: FeedViewController, story: Story, indexPath: IndexPath)
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
    
    delegate?.fetchStories(vc: self)
  }
  
  func showStories(stories: [Story]) {
    
    viewModel = FeedViewModel(stories: stories)
    
    if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      layout.itemSize = sizeForItem(withFlowLayout: layout)
    }
    
    collectionView.reloadData()
  }
  
  func changeToHorizontalFeedType(scrollToIndexPath indexPath: IndexPath) {
    
    UIView.animate(withDuration: 0.5) {[self] in
      
      if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
        
        layout.scrollDirection = .horizontal
        layout.itemSize = sizeForItem(withFlowLayout: layout)
        let horizontalInset = (collectionView.frame.size.width - layout.itemSize.width) / 2
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        //collectionView.setContentOffset(CGPoint(x: 1000, y: 0), animated: false)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
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
    delegate?.showPreview(vc: self, story: story, indexPath: indexPath)
  }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
  
}

