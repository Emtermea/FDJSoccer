//
//  SplashScreenViewController.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 04/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import UIKit

final class SplashScreenViewController: UIViewController {
    
    // MARK: - Property
    
    var presenter: SplashScreenPresenterProtocol!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.retrieve()
    }
}

extension SplashScreenViewController: SplashScreenPresenterDelegate {
    func showAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "An error has occurred",
                                          message: "Please check your internet connection",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                alert.dismiss(animated: true, completion: {
                    self.presenter.retrieve()
                })
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
