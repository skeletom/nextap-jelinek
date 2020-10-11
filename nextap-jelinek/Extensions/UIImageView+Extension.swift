//
//  UIImageView+Extension.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 11/10/2020.
//

import Foundation
import UIKit

extension UIImageView {
  
  func downloadImage(fromLink link: String?) {
    
    guard let link = link, let url = URL(string: link) else { return }
    URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
      
      DispatchQueue.main.async { [weak self] in
        if let data = data {
          self?.image = UIImage(data: data)
        }
      }
    })
    .resume()
  }
}
