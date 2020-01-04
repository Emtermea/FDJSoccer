//
//  SplashScreenViewController.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 04/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    // MARK: - Property

    var presenter: SplashScreenPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.retrieve()
    }
}
