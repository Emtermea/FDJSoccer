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
        
        guard let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SplashScreenViewController") as? SplashScreenViewController else {
            return UIViewController()
        }
        
        let router = SplashScreenRouter()
        let presenter = SplashScreenPresenter(router: router)
        
        viewController.presenter = presenter
        router.splashViewController = viewController
        
        return viewController
    }
}
