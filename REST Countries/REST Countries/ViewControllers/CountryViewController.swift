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
    private let countryViewModel = CountryViewModel()
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

        countryViewModel.delegate = self
        locationManager.locationManagerDelegate = self
        tableView?.dataSource = self
        tableView?.tableFooterView = UIView()
        
        setupSearchBar()
        setupMyLocationButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationPermissionManager.checkPermission(self)
    }
    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    private func setupMyLocationButton() {
        let myLocationButton = UIBarButtonItem(image: UIImage(named: "location")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(openMyLocation(_:)))
        myLocationButton.tintColor = .white
        navigationItem.rightBarButtonItem = myLocationButton
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc private func openMyLocation(_ sender: UIBarButtonItem) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: MyLocationViewController.identifier) as? MyLocationViewController else {
            return
        }
        
        vc.myCountryName = locationManager.myCountryName
        let nav = NavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
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

// MARK: - LocationManagerDelegate
extension CountryViewController: LocationManagerDelegate {
    func locationManagerDidUpdate(_ locationManager: LocationManager) {
        countryViewModel.requestAllCountries()
    }

    func locationManagerGotCurrentCity(_ locationManager: LocationManager) {
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}

// MARK: - CountryViewModelDelegate
extension CountryViewController: CountryViewModelDelegate {
    func didReceiveCountries(countries: [Country]) {
        guard let myLocation = locationManager.myLocation else {
            self.countries = countries
            return
        }
        
        self.countries = countries.sorted(by: {
            $0.distance(to: myLocation) < $1.distance(to: myLocation)
        })
    }
    
    func didFailDownloadCountries(error: Error) {
        print("error")
    }
}

// MARK: - UISearchBarDelegate
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

// MARK: - UISearchResultsUpdating
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
            countryViewModel.requestCountriesByName(countryName: searchText)
        case .capital:
            countryViewModel.requestCountriesByCapital(capital: searchText)
        case .language:
            if searchText.count == 2 {
                countryViewModel.requestCountriesByLanguage(language: searchText)
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
