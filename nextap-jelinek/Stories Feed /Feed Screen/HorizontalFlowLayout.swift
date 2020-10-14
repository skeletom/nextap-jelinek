//
//  HorizontalFlowLayout.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 13/10/2020.
//

import Foundation
import UIKit

class HorizontalFlowLayout: UICollectionViewFlowLayout {
  
  override init() {
    super.init()
    
    self.minimumLineSpacing = 10
    self.minimumInteritemSpacing = 10
    self.scrollDirection = .horizontal
    self.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) 
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    
    let collectionViewSize: CGSize = collectionView!.bounds.size
    var offsetAdjustment = CGFloat.greatestFiniteMagnitude
    let leftInset: CGFloat = (collectionViewSize.width - itemSize.width) / 2
    let horizontalOffset = proposedContentOffset.x + leftInset
    let targetRect = CGRect(origin: CGPoint(x: proposedContentOffset.x, y: 0), size: collectionViewSize)
    
    for layoutAttributes in super.layoutAttributesForElements(in: targetRect)! {
      
      let itemOffset = layoutAttributes.frame.origin.x
      if (abs(itemOffset - horizontalOffset) < abs(offsetAdjustment)) {
        offsetAdjustment = itemOffset - horizontalOffset
      }
    }
    
    let targetPoint = CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    return targetPoint
  }
}
