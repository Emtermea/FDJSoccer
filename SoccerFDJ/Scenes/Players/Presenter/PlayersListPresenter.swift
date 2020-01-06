//
//  PlayersListPresenter.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import Foundation

protocol PlayersListPresenterProtocol {
    func retrievePlayers()
    
    func numberOfRows() -> Int
    func numberOfSections() -> Int
    func cellViewModelForRowAt(_ index: Int) -> PlayersListViewModelProtocol?
}

protocol PlayersListViewModelProtocol {
    var name: String { get }
    var position: String { get }
    var price: String { get }
    var profileUrl: String? { get }
    var thumbUrl: String { get }
    var birthDate: String { get }
}

final class PlayersListPresenter {
    private let router: PlayersRouterProtocol
    weak var delegate: PlayersListPresenterDelegate?
    private let playersRepository: PlayersRepositoryProtocol
    private var playersViewModels: [PlayersListViewModelProtocol] = []
    private let teamName: String
    
    init(playersRepository: PlayersRepositoryProtocol, teamName: String, router: PlayersRouterProtocol) {
        self.playersRepository = playersRepository
        self.teamName = teamName
        self.router = router
    }
}

protocol PlayersListPresenterDelegate: class {
    func startLoading()
    func stopLoading()
    func reloadPresenter()
    func showAlert()
}

extension PlayersListPresenter: PlayersListPresenterProtocol {
    func retrievePlayers() {
        self.delegate?.startLoading()
        
        self.playersRepository.retrievePlayers(in: self.teamName, success: { [weak self] players in
            guard let self = self else { return }
            self.delegate?.stopLoading()
            
            self.playersViewModels = players.players.map {
                PlayersListViewModel($0)
            }
            
            self.delegate?.reloadPresenter()
            
            }, failure: { error in
                self.delegate?.showAlert()
        })
    }
    
    func numberOfRows() -> Int {
        return self.playersViewModels.count
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func cellViewModelForRowAt(_ index: Int) -> PlayersListViewModelProtocol? {
        guard index < self.playersViewModels.count else { return nil }
        return self.playersViewModels[index]
    }
}


private struct PlayersListViewModel: PlayersListViewModelProtocol {
    var name: String
    var position: String
    var price: String
    var profileUrl: String?
    var thumbUrl: String
    var birthDate: String
    
    init(_ player: Players.Player) {
        self.name = player.name
        self.position = player.position
        self.price = player.price
        self.profileUrl = player.profileUrl
        self.thumbUrl = player.thumbUrl
        self.birthDate = player.birthDate
    }
}
