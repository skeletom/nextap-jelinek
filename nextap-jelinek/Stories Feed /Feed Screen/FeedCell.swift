//
//  StoryVerticalCell.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 11/10/2020.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
  @IBOutlet weak var storyImageView: UIImageView!
  @IBOutlet weak var storyTitleLabel: UILabel!
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var avatarNameLabel: UILabel!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.layer.cornerRadius = 12.0
    self.layer.borderWidth = 3
    self.layer.borderColor = UIColor(named: "Gold")!.cgColor
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height / 2
    avatarImageView.layer.borderWidth = 1
    avatarImageView.layer.borderColor = UIColor.white.cgColor
  }
  
  func setup(withStory story: Story, feedDirection: UICollectionView.ScrollDirection) {
    
    storyImageView.image = nil
    storyImageView.downloadImage(fromLink: story.coverImageURL)
    
    avatarImageView.image = nil
    avatarImageView.downloadImage(fromLink: story.user.avatarImageURL)
    
    avatarNameLabel.text = story.user.displayName
    avatarNameLabel.isHidden = story.user.displayName == nil
    
    switch feedDirection {
    case .vertical:
      storyTitleLabel.isHidden = true
    case .horizontal:
      storyTitleLabel.text = story.title
      storyTitleLabel.isHidden = storyTitleLabel.text == nil
    @unknown default:()
    }
  }
}
