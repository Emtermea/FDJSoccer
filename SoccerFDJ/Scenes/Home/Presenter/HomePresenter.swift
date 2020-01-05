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

protocol HomeLeaguesListViewModelProtocol {
    var title: String { get }
}

protocol HomeListOfTeamViewModelProtocol {
    var image: UIImage { get }
}

protocol HomePresenterProtocol {
    func retrieveBy(name: String)
    func debounceSearch(name: String)
    func numberOfRows() -> Int
    func numberOfSections() -> Int
    func cellViewModelForRowAt(_ index: Int) -> HomeLeaguesListViewModelProtocol?
    func didSelect(_ index: Int)
}

protocol HomePresenterDelegate: class {
    func hideSearchController()
    func displayLeaguesSearch()
}

final class HomePresenter {
    
    // MARK:  Properties
    
    weak var delegate: HomePresenterDelegate?
    
    private let leaguesRepository: LeaguesDataRepositoryProtocol
    private var currentSearchLeagues: [HomeLeaguesListViewModelProtocol] = []
    private var currentTeamLeague: [HomeListOfTeamViewModelProtocol] = []
    private var workItem = DispatchWorkItem(block: {})
    
    // MARK:  Init
    
    init(leaguesRepository: LeaguesDataRepositoryProtocol) {
        self.leaguesRepository = leaguesRepository
    }
    
}

extension HomePresenter: HomePresenterProtocol {
    func retrieveBy(name: String) {
        self.leaguesRepository.retrieveLeaguesBy(name: name, success: {[weak self] leagues in
            guard let self = self else { return }
            
            self.currentSearchLeagues = leagues.map {
                HomeLeaguesListViewModel(title: $0.name)
            }
            self.delegate?.displayLeaguesSearch()
            
        }, failure: {[weak self] error in
            guard let self = self else { return }
            
            self.delegate?.hideSearchController()
        })
    }
    
    func debounceSearch(name: String) {
        workItem.cancel()
        guard name.count > 2 else {
            self.delegate?.hideSearchController()
            return
        }
        
        workItem = DispatchWorkItem(block: {[weak self] in
            guard let self = self else { return }
            self.retrieveBy(name: name)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200), execute: workItem)
    }
    
    func numberOfRows() -> Int {
        return self.currentSearchLeagues.count
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func cellViewModelForRowAt(_ index: Int) -> HomeLeaguesListViewModelProtocol? {
        guard index < self.currentSearchLeagues.count else { return nil }
        return self.currentSearchLeagues[index]
    }
    
    func didSelect(_ index: Int) {
                    // TODO: check si index exist
            //        self.currentSeachLeagues[index] else { return nil }
        
        //  FAIRE DELETE HIDE SEARCH == tableView
        
        // self.delegate?.hideSearch()
        
        
//        let league = self.currentSeachLeagues[index]
        
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

private struct HomeLeaguesListViewModel: HomeLeaguesListViewModelProtocol {
    var title: String
}
