//
//  HomePresenter.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 03/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import UIKit

enum HomePresenterRetrieveByError: Error {
    case empty
}

protocol HomeListOfLeaguesViewModelProtocol {
    var title: String { get }
}

protocol HomeListOfTeamViewModelProtocol {
    var image: UIImage { get }
}

protocol HomePresenterProtocol {
    func retrieveBy(league: String)
    func numberOfRows() -> Int
    func numberOfSections() -> Int
    func cellForRowAt(_ index: Int) -> HomeListOfLeaguesViewModelProtocol?
    func didSelect(_ index: Int)
}

protocol HomePresenterDelegate: class {
    func emptyLeague()
    func displayLeaguesSarch()
}

final class HomePresenter {
    
    // MARK:  Properties
    
    weak var delegate: HomePresenterDelegate?
    
    private let leaguesRepository: LeaguesDataRepositoryProtocol
    
    private var currentSeachLeagues: [HomeListOfLeaguesViewModelProtocol] = []
    private var currentTeamLeague: [HomeListOfTeamViewModelProtocol] = []
    
    // MARK:  Init
    
    init(leaguesRepository: LeaguesDataRepositoryProtocol) {
        self.leaguesRepository = leaguesRepository
    }
    
}

extension HomePresenter: HomePresenterProtocol {
    func retrieveBy(league: String) {
        self.leaguesRepository.retrieveBy(leagues: league, success: {[weak self] leagues in
            guard let self = self else { return }
            
            self.currentSeachLeagues = leagues.map( {
                HomeListOfLeaguesViewModel(title: $0.leagueName)
            })
            
            self.delegate?.displayLeaguesSarch()
        }, failure: {[weak self] error in
            guard let self = self else { return }
            
            self.delegate?.emptyLeague()
        })
    }
    
    func numberOfRows() -> Int {
        return self.currentSeachLeagues.count
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func cellForRowAt(_ index: Int) -> HomeListOfLeaguesViewModelProtocol? {
        // TODO: check si index exist
//        self.currentSeachLeagues[index] else { return nil }
        
        return self.currentSeachLeagues[index]
    }
    
    func didSelect(_ index: Int) {
                    // TODO: check si index exist
            //        self.currentSeachLeagues[index] else { return nil }
        
        //  FAIRE DELETE HIDE SEARCH == tableView
        
        // self.delegate?.hideSearch()
        
        
        let league = self.currentSeachLeagues[index]
        
//        self.teamRepository.retrieveBy(league, success: { teams in
//            convert teams via => viewModel
//
//            currentTeamLeague == viewModel
//
//            delegate refresh collection view
//        }, failure: { error in
//             delegate error
//        })
    }
    
}

private struct HomeListOfLeaguesViewModel: HomeListOfLeaguesViewModelProtocol {
    var title: String
}
