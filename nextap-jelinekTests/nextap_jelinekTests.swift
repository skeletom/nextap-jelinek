//
//  nextap_jelinekTests.swift
//  nextap-jelinekTests
//
//  Created by Tomas Jelinek on 09/10/2020.
//

import XCTest
@testable import nextap_jelinek

class nextap_jelinekTests: XCTestCase {
  
  func testGetStoriesRequest() {
    
    let responseExpectation = expectation(description: "Download stories")
    var responseResult: RequestStoriesResult?
    
    let request = GetStoriesRequest()
    request.send { (result) in
      responseResult = result
      responseExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 10) { (error) in
      
      XCTAssertNotNil(responseResult)
      
      var stories: [Story] = []
      switch responseResult! {
      case .success(let fetchedStories):
        stories = fetchedStories
      case .failure(let error):
        XCTFail("Failed to load stories. \(error)")
      }
      
      XCTAssertGreaterThan(stories.count, 0)
    }
  }
}

