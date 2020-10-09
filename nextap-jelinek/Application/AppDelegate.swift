//
//  AppDelegate.swift
//  nextap-jelinek
//
//  Created by Tomas Jelinek on 09/10/2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  private var coordinator: AppCoordinator?
  private var dependencies: Dependencies!
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    dependencies = Dependencies(userDefaultsManager: UserDefaultsManager())
    
    let navController = UINavigationController()
    navController.setNavigationBarHidden(true, animated: false)
    coordinator = AppCoordinator(navigationController: navController, dependencies: dependencies)
    coordinator?.start()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navController
    window?.makeKeyAndVisible()
    
    return true
  }
}

