//
//  GetStoriesRequest.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 09/10/2020.
//


import Foundation

enum NetworkingError: Error {
  case unexpected, timeout
}

class GetStoriesRequest {
  
  var task: URLSessionDataTask?
  
  func send(completion: @escaping RequestStoriesCompletion) {
    
    guard let requestUrl = URL(string: "https://api.steller.co/v1/users/76794126980351029/stories") else {
      completion(.failure(.unexpected))
      return
    }
    
    var request = URLRequest(url: requestUrl)
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) {[self] (data, response, error) in
      
      if let error = error {
        print("Response error \(error.localizedDescription)")
        let code = (error as NSError).code
        code == NSURLErrorTimedOut ? completion(.failure(.timeout)) : completion(.failure(.unexpected))
      } else if let data = data {
        guard let stories = stories(from: data) else {
          completion(.failure(.unexpected))
          return
        }
        completion(.success(stories))
      } else {
        print("Response unexpected error")
        completion(.failure(.unexpected))
      }
    }
    
    self.task = task
    task.resume()
  }
  
  private func stories(from data: Data) -> [Story]? {
    
    let decoder = JSONDecoder()
    
    do {
      let decodedData: StoriesData = try decoder.decode(StoriesData.self, from: data)
      return decodedData.data
    } catch let error {
      print("Failed to decode JSON. \(error.localizedDescription)")
      return nil
    }
  }
}
