//
//  CountryViewModel.swift
//  REST Countries Framework
//
//  Created by Cédric Rolland on 23.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

public protocol CountryViewModelDelegate: AnyObject {
    func didReceiveCountries(countries: [Country])
    func didFailDownloadCountries(error: Error)
}

public class CountryViewModel {
    
    public weak var delegate: CountryViewModelDelegate?
    
    private var service: Service?
    
    public init(service: Service = Service()) {
        self.service = service
    }
    
    public func requestMyCountry(countryName: String) {
        service?.requestMyCountry(countryName: countryName, completion: completionBlock)
    }
    
    public func requestAllCountries() {
        service?.requestAllCountries(completion: completionBlock)
    }
    
    public func requestCountriesByName(countryName: String) {
        service?.requestCountryByName(countryName: countryName, completion: completionBlock)
    }
    
    public func requestCountriesByCapital(capital: String) {
        service?.requestCountryByCapital(capital: capital, completion: completionBlock)
    }
    
    public func requestCountriesByLanguage(language: String) {
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
