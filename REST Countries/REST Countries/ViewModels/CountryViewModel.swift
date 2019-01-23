//
//  CountryViewModel.swift
//  REST Countries
//
//  Created by Cédric Rolland on 23.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import Foundation

protocol CountryViewModelDelegate: AnyObject {
    func didReceiveCountries(countries: [Country])
    func didFailDownloadCountries(error: Error)
}

class CountryViewModel {
    
    weak var delegate: CountryViewModelDelegate?
    
    let service = Service()
    
    func requestCountriesByName(countryName: String) {
        service.requestCountryByName(countryName: countryName, completion: completionBlock(result:error:))
    }
    
    func requestCountriesByCapital(capital: String) {
        service.requestCountryByCapital(capital: capital, completion: completionBlock(result:error:))
    }
    
    func requestCountriesByLanguage(language: String) {
        service.requestCountryByLanguage(language: language, completion: completionBlock(result:error:))
    }
    
    private func completionBlock(result: [Country]?, error: Error?) {
        weak var weakSelf = self
        
        guard let result = result else {
            if let error = error {
                weakSelf?.delegate?.didFailDownloadCountries(error: error)
            }
            
            return
        }
        
        weakSelf?.delegate?.didReceiveCountries(countries: result)
    }
}
