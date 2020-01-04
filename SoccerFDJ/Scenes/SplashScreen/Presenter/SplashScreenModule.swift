//
//  SplashScreenModule.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 04/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import UIKit

class SplashScreenModule {
    func makeView() -> UIViewController {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "SplashScreenViewController") as! SplashScreenViewController
        
            let router = SplashScreenRouter()
            let presenter = SplashScreenPresenter(router: router)
            viewController.presenter = presenter
            
            router.splashViewController = viewController

        return viewController
    }
}
