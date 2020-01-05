//
//  SplashScreenRouter.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 03/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import UIKit

protocol SplashScreenRouterProtocol {
    func routeToHome()
}

final class SplashScreenRouter: SplashScreenRouterProtocol {
    weak var splashViewController: UIViewController?
    
    private func makeHomeViewController() -> HomeViewController {
        let presenter = HomePresenter(leaguesRepository: LeaguesDataRepository())
        
//        let router = HomeRouter()
        
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let homeViewController = story.instantiateViewController(identifier: "ViewController") as! HomeViewController
        presenter.delegate = homeViewController
        homeViewController.presenter = presenter
//        router.homeViewController = homeViewController
        
        return homeViewController
    }
    
    func routeToHome() {
        splashViewController?.navigationController?.pushViewController(makeHomeViewController(), animated: false)
    }
}
