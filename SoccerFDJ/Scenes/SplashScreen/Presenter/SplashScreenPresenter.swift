//
//  SplashScreenPresenter.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 03/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import Foundation

protocol SplashScreenPresenterProtocol {
    func retrieve()
}

final class SplashScreenPresenter {
    private let router: SplashScreenRouterProtocol
    
    init(router: SplashScreenRouterProtocol) {
        self.router = router
    }
    
}

extension SplashScreenPresenter: SplashScreenPresenterProtocol {
    func retrieve() {
        print("SPLASHSCREEN PRESENTER")
//        self.repo1.retrieve(success: { leagues in
//            self.repo2.save(request == leagues)
//
//            self.router.routeToHome()
//        }, failure: {
//            // quoi faire ici ?
//        })
    }
}
