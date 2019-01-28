//
//  CountryViewModel.swift
//  REST Countries
//
//  Created by Cédric Rolland on 23.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

protocol CountryViewModelDelegate: AnyObject {
    func didReceiveCountries(countries: [Country])
    func didFailDownloadCountries(error: Error)
}

class CountryViewModel {
    
    weak var delegate: CountryViewModelDelegate?
    
    var service: Service?
    
    init(service: Service = Service()) {
        self.service = service
    }
    
    func requestMyCountry(countryName: String) {
        service?.requestMyCountry(countryName: countryName, completion: completionBlock)
    }
    
    func requestAllCountries() {
        service?.requestAllCountries(completion: completionBlock)
    }
    
    func requestCountriesByName(countryName: String) {
        service?.requestCountryByName(countryName: countryName, completion: completionBlock)
    }
    
    func requestCountriesByCapital(capital: String) {
        service?.requestCountryByCapital(capital: capital, completion: completionBlock)
    }
    
    func requestCountriesByLanguage(language: String) {
        service?.requestCountryByLanguage(language: language, completion: completionBlock)
    }
    
    private func completionBlock(result: [Country]?, error: Error?) {
        unowned let unownedSelf = self
        
        guard let result = result else {
            if let error = error {
                unownedSelf.delegate?.didFailDownloadCountries(error: error)
            }
            
            return
        }
        
        unownedSelf.delegate?.didReceiveCountries(countries: result)
    }
}
