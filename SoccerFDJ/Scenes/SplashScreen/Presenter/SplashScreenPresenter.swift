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

protocol SplashScreenPresenterDelegate: class {
    func showAlert()
}

final class SplashScreenPresenter {
    
    // MARK: - Properties
    
    weak var delegate: SplashScreenPresenterDelegate?
    private let leaguesApiRepository: LeaguesApiRepositoryProtocol
    private let leaguesDataRepository: LeaguesDataRepositoryProtocol
    private let router: SplashScreenRouterProtocol
    
    init(leaguesApiRepository: LeaguesApiRepositoryProtocol,
         leaguesDataRepository: LeaguesDataRepositoryProtocol,
         router: SplashScreenRouterProtocol) {
        self.leaguesApiRepository = leaguesApiRepository
        self.leaguesDataRepository = leaguesDataRepository
        self.router = router
    }
}

extension SplashScreenPresenter: SplashScreenPresenterProtocol {
    func retrieve() {
        self.leaguesApiRepository.retrieve(success: { leagues in
            self.leaguesDataRepository.saveLeagues(self.filterLeaguesBySoccer(leagues))
            self.router.routeToHome()
        }, failure: { error in
            self.delegate?.showAlert()
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
