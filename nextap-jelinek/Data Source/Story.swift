//
//  Story.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 09/10/2020.
//

import Foundation

struct StoriesData: Codable {
  
  var data: [Story]
}

struct Story: Codable {
  
  var id: String
  var displayName: String?
  var coverImageURL: String?
  var avatarImageURL: String?
  
  enum CodingKeys: String, CodingKey {
    
    case id
    case displayName = "display_name"
    case coverImageURL = "cover_src"
    case avatarImageURL = "avatar_image_url"
  }
}
