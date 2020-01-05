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
    private let leaguesDataRepository: LeaguesDataRepositoryProtocol
    
    init(router: SplashScreenRouterProtocol,
         leaguesApiRepository: LeaguesApiRepositoryProtocol = LeaguesApiRepository(),
         leaguesDataRepository: LeaguesDataRepositoryProtocol = LeaguesDataRepository()) {
        self.router = router
        self.leaguesApiRepository = leaguesApiRepository
        self.leaguesDataRepository = leaguesDataRepository
    }
}

extension SplashScreenPresenter: SplashScreenPresenterProtocol {
    func retrieve() {
        self.leaguesApiRepository.retrieve(success: { leagues in
            self.leaguesDataRepository.saveLeagues(self.filterLeaguesBySoccer(leagues))
            self.router.routeToHome()
        }, failure: { error in
            //router
            //alert in home VC
        })
    }
    
    ///Keep only Soccer leagues
    func filterLeaguesBySoccer(_ leagues: Leagues) -> Leagues {
        let soccerLeagues = leagues.leagues.filter {
            $0.sport == "Soccer"
        }
        return Leagues(leagues: soccerLeagues)
    }
}
