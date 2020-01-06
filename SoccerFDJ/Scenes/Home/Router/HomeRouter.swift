//
//  HomeRouter.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import UIKit

protocol HomeRouterProtocol {
    func routeToPlayersList(of team: String)
}

final class HomeRouter: HomeRouterProtocol {
    private let homeViewController: UIViewController
    
    init(homeViewController: HomeViewController) {
        self.homeViewController = homeViewController
    }
    
    private func makePlayersListViewController(of team: String) -> PlayersListViewController {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        
        let requestManager = RequestManager()
        let playersViewController = story.instantiateViewController(identifier: "PlayersListViewController") as! PlayersListViewController
        let router = PlayersRouter(playersListViewController: playersViewController)
        let presenter = PlayersListPresenter(playersRepository: PlayersRepository(requestManager: requestManager),
                                             teamName: team,
                                             router: router)
        
        presenter.delegate = playersViewController
        playersViewController.presenter = presenter
        playersViewController.title = team
        
        return playersViewController
    }
    
    func routeToPlayersList(of team: String) {
        homeViewController.navigationController?.pushViewController(makePlayersListViewController(of: team), animated: false)
    }
}
