//
//  HomeViewController.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 03/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: IBOutlet
    @IBOutlet private(set) weak var tableView: UITableView!
    
    //MARK: Properties
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search by league"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()
    
    var presenter: HomePresenterProtocol!
    
    //MARK: Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSearchController()
        self.setupTableView()
        self.setupCollectionView()
    }
    
    private func setupSearchController() {
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
    }
    
    private func setupTableView() {
        // faire barre search + > 3 char + delay 0.2
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //        self.presenter.retrieveBy(league: "lig")
    }
    
    private func setupCollectionView() {
        
    }
    
}

extension HomeViewController: HomePresenterDelegate {
    func emptyLeague() {
        //error
    }
    
    func displayLeaguesSearch() {
        //        tableview.reloadData()
    }
}

extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        self.presenter.retrieveBy(name: text)
    }
    
}


extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
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

