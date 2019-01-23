//
//  CountryViewController.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    
    private lazy var locationPermissionManager = LocationPermissionManager()
    private let searchController = SearchController(searchResultsController: nil)
    private let dataSource = CountryViewModel()
    private let endpoints = [Endpoints.name, Endpoints.capital, Endpoints.language]
    private var scope: SearchScope = .name
    
    private var countries = [Country]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "REST Country"
        
        navigationController?.isNavigationBarHidden = false
        
        locationPermissionManager.checkPermission(self)
        
        dataSource.delegate = self
        tableView?.dataSource = self
        tableView?.tableFooterView = UIView()
        
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func searchCountry() {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        switch scope {
        case .name:
            dataSource.requestCountriesByName(countryName: searchText)
        case .capital:
            dataSource.requestCountriesByCapital(capital: searchText)
        case .language:
            dataSource.requestCountriesByLanguage(language: searchText)
        }
    }
}

extension CountryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier) as? CountryCell else {
            return UITableViewCell()
        }
        
        cell.config(withCountry: countries[safe: indexPath.row])
        return cell
    }
}

extension CountryViewController: CountryViewModelDelegate {
    func didReceiveCountries(countries: [Country]) {
        self.countries = countries
    }
    
    func didFailDownloadCountries(error: Error) {
        print("error")
    }
}

extension CountryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        scope = SearchScope.init(id: selectedScope) ?? .name
        searchCountry()
    }
}

extension CountryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchCountry()
    }
}
