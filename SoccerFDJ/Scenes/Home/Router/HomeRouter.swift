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
    weak var homeViewController: UIViewController?
    
    init(homeViewController: HomeViewController) {
        self.homeViewController = homeViewController
    }
    
    func routeToPlayersList(of team: String) {
        homeViewController?.navigationController?.pushViewController(HomeModule().makePlayersListViewController(of: team),
                                                                     animated: false)
    }
}
