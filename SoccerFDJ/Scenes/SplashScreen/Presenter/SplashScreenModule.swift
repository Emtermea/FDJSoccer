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
        
        guard let viewController = UIStoryboard.init(name: "SplashScreen", bundle: nil).instantiateViewController(withIdentifier: "SplashScreenViewController") as? SplashScreenViewController else {
            return UIViewController()
        }
        
        let router = SplashScreenRouter()
        let requestManager = RequestManager()
        let leaguesApiRepository = LeaguesApiRepository(requestManager: requestManager)
        let leaguesDataRepository = LeaguesDataRepository()
        
        let presenter = SplashScreenPresenter(leaguesApiRepository: leaguesApiRepository,
                                              leaguesDataRepository: leaguesDataRepository,
                                              router: router)
        presenter.delegate = viewController
        viewController.presenter = presenter
        router.splashViewController = viewController
        
        return viewController
    }
}
