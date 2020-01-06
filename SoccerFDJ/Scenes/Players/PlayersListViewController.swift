//
//  PlayersListViewController.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import UIKit

class PlayersListViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    //MARK: - Properties
    var presenter: PlayersListPresenterProtocol!
    private let cellIdentifier = "PlayersListTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.retrievePlayers()
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 180.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.backgroundColor = .white
    }
}

extension PlayersListViewController: PlayersListPresenterDelegate {
    func startLoading() {
        DispatchQueue.main.async {
            self.loader.startAnimating()
            self.tableView.isHidden = true
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.tableView.isHidden = false
        }
    }
    
    func reloadPresenter() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension PlayersListViewController: UITableViewDelegate {
    
}

extension PlayersListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        self.presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if let playerCell = cell as? PlayersListTableViewCell {
            playerCell.setup(with: self.presenter.cellViewModelForRowAt(indexPath.row))
        }
        return cell
    }
}
 
