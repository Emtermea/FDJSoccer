//
//  HomeModule.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 06/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import UIKit

class HomeModule {
    func makePlayersListViewController(of team: String) -> PlayersListViewController {
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
}
