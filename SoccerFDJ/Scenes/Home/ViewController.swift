//
//  ViewController.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 03/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private(set) weak var tableView: UITableView!
    
    var presenter: HomePresenterProtocol!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // faire barre search + > 3 char + delay 0.2
        self.tableView.delegate = self
        self.tableView.dataSource = self
//        self.presenter.retrieveBy(league: "lig")
    }

}

extension ViewController: HomePresenterDelegate {
    func emptyLeague() {
        //error
    }

    func displayLeaguesSarch() {
//        tableview.reloadData()
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
//        return presenter.numberOfSections()
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return presenter.numberOfRows()
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell dispatchQueue
        
        let cell = UITableViewCell()
        
//        let viewModel = presenter.cellForRowAt(indexPath.row)
        
//        cell.configure(viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(indexPath.row)
    }
    
    
}

