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
    private let locationManager = LocationManager()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.requestAllCountries()
    }
    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
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
        self.countries = countries.sorted(by: {
            $0.distance(to: locationManager.myLocation!) < $1.distance(to: locationManager.myLocation!)
        })
    }
    
    func didFailDownloadCountries(error: Error) {
        print("error")
    }
}

extension CountryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        scope = SearchScope.init(id: selectedScope) ?? .name
        updatePlaceholder()
        searchForCountry()
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        switch scope {
        case .language:
            return (searchBar.text?.appending(text).count ?? 0) <= 2
        default:
            return true
        }
    }
}

extension CountryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchForCountry()
    }
}

private extension CountryViewController {
    func searchForCountry() {
        guard let searchText = searchController.searchBar.text, searchText.count > 0 else {
            return
        }
        
        switch scope {
        case .name:
            dataSource.requestCountriesByName(countryName: searchText)
        case .capital:
            dataSource.requestCountriesByCapital(capital: searchText)
        case .language:
            if searchText.count == 2 {
                dataSource.requestCountriesByLanguage(language: searchText)
            }
        }
    }
    
    func updatePlaceholder() {
        switch scope {
        case .name:
            searchController.searchBar.placeholder = Placeholder.name
        case .capital:
            searchController.searchBar.placeholder = Placeholder.capital
        case .language:
            searchController.searchBar.placeholder = Placeholder.language
        }
    }
}
