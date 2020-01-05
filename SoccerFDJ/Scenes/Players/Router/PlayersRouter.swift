//
//  PlayersRouter.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import UIKit

protocol PlayersRouterProtocol {
    func pop()
}

final class PlayersRouter: PlayersRouterProtocol {
    weak var playersListViewController: UIViewController?
    
    init(playersListViewController: UIViewController) {
        self.playersListViewController = playersListViewController
    }
    
    func pop() {
        playersListViewController?.navigationController?.popViewController(animated: true)
    }
}

