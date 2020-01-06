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
    @IBOutlet private(set) weak var collectionView: UICollectionView!
    
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
    private let collectionCellIdentifier = "TeamCollectionViewCell"
    
    
    //MARK: Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupSearchController()
        self.setupTableView()
        self.setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
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
        self.tableView.backgroundColor = .white
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: collectionCellIdentifier, bundle: nil), forCellWithReuseIdentifier: collectionCellIdentifier)
        self.collectionView.backgroundColor = .white
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
    
    func reloadTeams() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        self.searchController.isActive = false
    }
    
    func showAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Oups",
                                          message: "An error has occurred",
                                          preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    alert.dismiss(animated: true, completion: nil)
                }))
            self.present(alert, animated: true, completion: nil)
            }
        }
}

extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        self.presenter.debounceSearch(name: text)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didSelectLeague(indexPath.row)
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        self.presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: autoCompletionCellIdentifier, for: indexPath)
        
        if let autoCompleteCell = cell as? AutoCompletionTableViewCell {
            autoCompleteCell.viewModel = self.presenter.cellViewModelForRowAt(indexPath.row)
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.didSelectCollectionView(indexPath.item)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.presenter.numberOfSectionsInCollection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter.numberOfItemsInCollection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath)
        
        if let teamCell = cell as? TeamCollectionViewCell {
            teamCell.viewModel = self.presenter.collectionCellViewModelForItemAt(indexPath.item)
        }
        return cell
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width / 2.0), height: 150.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

