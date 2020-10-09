//
//  CoordinatorProtocol.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 09/10/2020.
//

import Foundation
import UIKit

protocol Coordinator {
  
  var childCoordinators: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }
  var dependencies: Dependencies { get }
  
  func start()
}
