//
//  AppDelegate.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 03/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootNavigationController = UINavigationController()
        let viewController = SplashScreenModule()
        rootNavigationController.setViewControllers([viewController.makeView()], animated: false)
        
        window?.makeKeyAndVisible()
        window?.rootViewController = rootNavigationController
        return true
    }
    
}

