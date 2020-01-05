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
    
    private let autoCompletionCellIdentifier = "AutoCompletionTableViewCell"
    private let collectionCellIdentifier = "CollectionViewCell"
    
    
    //MARK: Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: false)
        self.setupSearchController()
        self.setupTableView()
        self.setupCollectionView()
    }
    
    private func setupSearchController() {
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: autoCompletionCellIdentifier, bundle: nil), forCellReuseIdentifier: autoCompletionCellIdentifier)
        self.hideSearchController()
    }
    
    private func setupCollectionView() {
        
    }
    
}

extension HomeViewController: HomePresenterDelegate {
    func hideSearchController() {
        self.tableView.isHidden = true
    }
    
    func displayLeaguesSearch() {
        self.tableView.reloadData()
        self.tableView.isHidden = false
    }
}

extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        self.presenter.debounceSearch(name: text)
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: autoCompletionCellIdentifier, for: indexPath)
        
        if let autoCompleteCell = cell as? AutoCompletionTableViewCell {
            autoCompleteCell.viewModel = self.presenter.cellViewModelForRowAt(indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(indexPath.row)
    }
    
}

