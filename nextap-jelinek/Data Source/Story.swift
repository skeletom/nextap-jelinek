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
  var coverImageURL: String?
  var title: String?
  var user: User
  
  enum CodingKeys: String, CodingKey {
    
    case id
    case coverImageURL = "cover_src"
    case title
    case user
  }
}

struct User: Codable {
  
  var displayName: String?
  var avatarImageURL: String?
  
  enum CodingKeys: String, CodingKey {
    
    case displayName = "display_name"
    case avatarImageURL = "avatar_image_url"
  }
}
