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

protocol HomeTeamsListViewModelProtocol {
    var imageUrl: String { get }
    var teamName: String { get }
}

protocol HomePresenterProtocol {
    func retrieveBy(name: String)
    func debounceSearch(name: String)
    func numberOfRows() -> Int
    func numberOfSections() -> Int
    func cellViewModelForRowAt(_ index: Int) -> HomeLeaguesListViewModelProtocol?
    func didSelectLeague(_ index: Int)
    
    func numberOfItemsInCollection() -> Int
    func numberOfSectionsInCollection() -> Int
    func collectionCellViewModelForItemAt(_ index: Int) -> HomeTeamsListViewModelProtocol?
    func didSelectCollectionView(_ index: Int)
}

protocol HomePresenterDelegate: class {
    func hideSearchController()
    func displayLeaguesSearch()
    
    func reloadTeams()
    func showAlert(isBlockingAction: Bool)
}

final class HomePresenter {
    
    // MARK: - Properties
    
    private let router: HomeRouterProtocol
    weak var delegate: HomePresenterDelegate?
    private let leaguesRepository: LeaguesDataRepositoryProtocol
    private var currentSearchLeagues: [HomeLeaguesListViewModelProtocol] = []
    private var currentLeagueTeams: [HomeTeamsListViewModelProtocol] = []
    private var workItem = DispatchWorkItem(block: {})
    private let teamsRepository: TeamsRepositoryProtocol
    
    // MARK: - Init
    
    init(leaguesRepository: LeaguesDataRepositoryProtocol,
         teamsRepository: TeamsRepositoryProtocol,
         router: HomeRouterProtocol) {
        self.leaguesRepository = leaguesRepository
        self.teamsRepository = teamsRepository
        self.router = router
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
    
    // MARK: - TableView
    
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
    
    func didSelectLeague(_ index: Int) {
        guard index < self.currentSearchLeagues.count else { return }
        
        let league = self.currentSearchLeagues[index]
        self.teamsRepository.retrieveTeams(in: league.title, success: {[weak self] teams in
            guard let self = self else { return }
            self.delegate?.hideSearchController()
            
            self.currentLeagueTeams = teams.teams.map {
                HomeTeamsListViewModel(imageUrl: $0.badge, teamName: $0.name)
            }
            self.delegate?.reloadTeams()
            
            }, failure: { error in
                self.delegate?.showAlert(isBlockingAction: false)
        })
    }
    
    // MARK: - CollectionView
    
    func numberOfItemsInCollection() -> Int {
        return currentLeagueTeams.count
    }
    
    func numberOfSectionsInCollection() -> Int {
        return 1
    }
    
    func collectionCellViewModelForItemAt(_ index: Int) -> HomeTeamsListViewModelProtocol? {
        guard index < self.currentLeagueTeams.count else { return nil }
        return self.currentLeagueTeams[index]
    }
    
    func didSelectCollectionView(_ index: Int) {
        guard index < self.currentLeagueTeams.count else { return }
        self.delegate?.reloadTeams()
        
        let viewModel = self.currentLeagueTeams[index]
        self.router.routeToPlayersList(of: viewModel.teamName)
    }
    
}

private struct HomeLeaguesListViewModel: HomeLeaguesListViewModelProtocol {
    var title: String
}

private struct HomeTeamsListViewModel: HomeTeamsListViewModelProtocol {
    var imageUrl: String
    var teamName: String
}
