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
    private let leaguesApiRepository: LeaguesApiRepositoryProtocol
    
    init(router: SplashScreenRouterProtocol, leaguesApiRepository: LeaguesApiRepositoryProtocol = LeaguesApiRepository()) {
        self.router = router
        self.leaguesApiRepository = leaguesApiRepository
    }
    
}

extension SplashScreenPresenter: SplashScreenPresenterProtocol {
    func retrieve() {
        print("SPLASHSCREEN PRESENTER")
        
        self.leaguesApiRepository.retrieve(success: { leagues in
            print(leagues)
            //save
            //router
            
        }, failure: { error in
            //router
            //alert in home VC
        })
        
    }
}
