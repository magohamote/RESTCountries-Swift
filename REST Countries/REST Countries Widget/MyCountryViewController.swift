//
//  MyCountryViewController.swift
//  REST Countries Widget
//
//  Created by Cédric Rolland on 26.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit
import NotificationCenter
import SVGKit
import REST_Countries_Framework

class MyCountryViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var flagView: SVGKFastImageView?
    @IBOutlet weak var countryNameLabel: UILabel?
    @IBOutlet weak var capitalLabel: UILabel?
    @IBOutlet weak var populationLabel: UILabel?
    @IBOutlet weak var regionLabel: UILabel?
    @IBOutlet weak var regionalBlocksControl: ItemSelectionControl?
    @IBOutlet weak var languagesControl: ItemSelectionControl?
    @IBOutlet weak var currenciesControl: ItemSelectionControl?
    
    private let locationManager = LocationManager()
    private let countryViewModel = CountryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        countryViewModel.delegate = self
        locationManager.locationManagerDelegate = self
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        let sharedDefaults = UserDefaults.init(suiteName: SharedUserDefaults.suiteName)
        
        if let data = sharedDefaults?.value(forKey: "myCountry") as? Data {
            do {
                guard let myCountry = try? PropertyListDecoder().decode(Country.self, from: data) else {
                    completionHandler(.failed)
                    return
                }
                
                updateUI(myCountry: myCountry)
                completionHandler(.newData)
            }
        } else {
            guard let myCountryName = locationManager.myCountryName else {
                completionHandler(.failed)
                return
            }
            
            countryViewModel.requestMyCountry(countryName: myCountryName)
            completionHandler(.newData)
        }
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            preferredContentSize = maxSize
        } else if activeDisplayMode == .expanded {
            preferredContentSize = CGSize(width: maxSize.width, height: 325)
        }
    }
    
    private func updateUI(myCountry: Country) {
        if let flag = myCountry.flag, let flagUrl = URL(string: flag) {
            flagView?.image = SVGKImage(contentsOf: flagUrl)
        }
        
        countryNameLabel?.text = myCountry.name
        capitalLabel?.text = myCountry.capital
        populationLabel?.text = String(myCountry.population.formattedWithSeparator)
        regionLabel?.text = myCountry.region
        regionalBlocksControl?.items = (myCountry.regionalBlocks ?? [RegionalBlock]()).map { $0.name }
        languagesControl?.items = (myCountry.languages ?? [Language]()).map { $0.name }
        currenciesControl?.items = (myCountry.currencies ?? [Currency]()).map { "\($0.name) - \($0.symbol)" }
    }
    
    private func hideUIComponent(isHidden: Bool) {
        countryNameLabel?.isHidden = isHidden
        capitalLabel?.isHidden = isHidden
        populationLabel?.isHidden = isHidden
        regionLabel?.isHidden = isHidden
        regionalBlocksControl?.isHidden = isHidden
        languagesControl?.isHidden = isHidden
        currenciesControl?.isHidden = isHidden
    }
}

extension MyCountryViewController: CountryViewModelDelegate {
    func didReceiveCountries(countries: [Country]) {
        guard let myCountry = countries.first else {
            return
        }
        
        DispatchQueue.main.async { [unowned self] in
            self.updateUI(myCountry: myCountry)
        }
    }
    
    func didFailDownloadCountries(error: Error) {}
}

extension MyCountryViewController: LocationManagerDelegate {
    func locationManagerDidUpdate(_ locationManager: LocationManager) {}
    
    func locationManagerGotCurrentCity(_ locationManager: LocationManager) {
        widgetPerformUpdate { _ in
            
        }
    }
}
