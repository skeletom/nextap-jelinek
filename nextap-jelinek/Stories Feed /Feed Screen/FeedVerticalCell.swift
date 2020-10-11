//
//  StoryVerticalCell.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 11/10/2020.
//

import UIKit

class FeedVerticalCell: UICollectionViewCell {
    
  @IBOutlet weak var storyImageView: UIImageView!
  @IBOutlet weak var storyTitleLabel: UILabel!
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var avatarNameLabel: UILabel!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.layer.cornerRadius = 12.0
    self.layer.borderWidth = 3
    self.layer.borderColor = UIColor(red: 0.5, green: 0.47, blue: 0.25, alpha: 1.0).cgColor
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height / 2
    avatarImageView.layer.borderWidth = 1
    avatarImageView.layer.borderColor = UIColor.white.cgColor
  }
  
  func setup(withStory story: Story, feedType: FeedType) {
    
    storyImageView.image = nil
    storyImageView.downloadImage(fromLink: story.coverImageURL)
    
    avatarImageView.image = nil
    avatarImageView.downloadImage(fromLink: story.user.avatarImageURL)
    
    avatarNameLabel.text = story.user.displayName
    avatarNameLabel.isHidden = story.user.displayName == nil
    
    switch feedType {
    case .vertical:
      storyTitleLabel.isHidden = true
    case .horizontal:
      storyTitleLabel.text = story.title
      storyTitleLabel.isHidden = storyTitleLabel.text == nil
    }
  }
}
