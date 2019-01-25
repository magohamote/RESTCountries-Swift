//
//  MyLocationViewController.swift
//  REST Countries
//
//  Created by Cédric Rolland on 24.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit
import CoreLocation

enum MyLocationHeaders: String, CaseIterable {
    case flag = "Flag"
    case fullName = "Name"
    case population = "Population"
    case capital = "Capital"
    case region = "Region"
    case regionalBlocks = "Regional blocks"
    case languages = "Languages"
    case currencies = "Currencies"
    
    init?(id : Int) {
        switch id {
        case 0: self = .flag
        case 1: self = .fullName
        case 2: self = .population
        case 3: self = .capital
        case 4: self = .region
        case 5: self = .regionalBlocks
        case 6: self = .languages
        case 7: self = .currencies
        default: return nil
        }
    }
}

class MyLocationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    
    var myCountryName: String?
    
    private var countryViewModel = CountryViewModel()
    private var myCountry: Country? {
        didSet {
            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Your location is"
        
        countryViewModel.delegate = self
        tableView?.dataSource = self
        tableView?.tableFooterView = UIView()
        
        setupDismiss()
        fetchCountryInfo()
    }
    
    private func setupDismiss() {
        let dismissButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismiss(_:)))
        dismissButton.tintColor = .white
        navigationItem.leftBarButtonItem = dismissButton
    }
    
    @objc private func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func fetchCountryInfo() {
        guard let myCountryName = myCountryName else {
            return
        }
        
        countryViewModel.requestMyCountry(countryName: myCountryName.replacingOccurrences(of: " ", with: "%20"))
    }
}

extension MyLocationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MyLocationHeaders.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let myLocation = myCountry, let header = MyLocationHeaders.init(id: section) else {
            return 0
        }
        
        switch header {
        case .regionalBlocks:
            guard let regionalBlocks = myLocation.regionalBlocks else {
                return 0
            }
            
            return regionalBlocks.count
        case .languages:
            guard let languages = myLocation.languages else {
                return 0
            }
            return languages.count
        case .currencies:
            guard let currencies = myLocation.currencies else {
                return 0
            }
            
            return currencies.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myLocationCell"),
            let header = MyLocationHeaders.init(id: indexPath.section),
            let myLocation = myCountry else {
            return UITableViewCell()
        }
        
        switch header {
        case .flag:
            // TODO
            return UITableViewCell()
        case .fullName:
            cell.textLabel?.text = myLocation.name
        case .population:
            cell.textLabel?.text = String(myLocation.population)
        case .capital:
            cell.textLabel?.text = myLocation.capital
        case .region:
            cell.textLabel?.text = myLocation.region
        case .regionalBlocks:
            cell.textLabel?.text = myLocation.regionalBlocks?[safe: indexPath.row]?.name
        case .languages:
            cell.textLabel?.text = myLocation.languages?[safe: indexPath.row]?.name
        case .currencies:
            cell.textLabel?.text = myLocation.currencies?[safe: indexPath.row]?.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MyLocationHeaders.init(id: section)?.rawValue
    }
}

extension MyLocationViewController: CountryViewModelDelegate {
    func didReceiveCountries(countries: [Country]) {
        myCountry = countries.first
    }
    
    func didFailDownloadCountries(error: Error) {
        print("error getting your country")
    }
}