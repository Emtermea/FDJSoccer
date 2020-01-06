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
    func routeToHomeWithAlert()
}

final class SplashScreenRouter: SplashScreenRouterProtocol {
    weak var splashViewController: UIViewController?
    
    private func makeHomeViewController() -> HomeViewController {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let homeViewController = story.instantiateViewController(identifier: "ViewController") as! HomeViewController
        let router = HomeRouter(homeViewController: homeViewController)
        let presenter = HomePresenter(leaguesRepository: LeaguesDataRepository(),
                                      teamsRepository: TeamsRepository(), 
                                      router: router)
        
        presenter.delegate = homeViewController
        homeViewController.presenter = presenter
        homeViewController.title = "Soccer Leagues Search"
        
        return homeViewController
    }
    
    func routeToHome() {
        splashViewController?.navigationController?.pushViewController(makeHomeViewController(), animated: false)
    }
    
    func routeToHomeWithAlert() {
        let viewController = self.makeHomeViewController()
        viewController.showAlert(isBlockingAction: true)
        splashViewController?.navigationController?.pushViewController(viewController, animated: false)
    }
}
