//
//  Service.swift
//  REST Countries
//
//  Created by Cédric Rolland on 23.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import Foundation

import Alamofire
import os.log

struct Service {
    
    func requestAllCountries(completion: @escaping (_ response: [Country]?, _ error: Error?) -> Void) {
        requestCountriesData(url: Endpoints.all) { response, error in
            completion(response, error)
        }
    }
    
    func requestCountryByName(countryName: String, completion: @escaping (_ response: [Country]?, _ error: Error?) -> Void) {
        requestCountriesData(url: Endpoints.name, queryParam: countryName) { response, error in
            completion(response, error)
        }
    }
    
    func requestCountryByCapital(capital: String, completion: @escaping (_ response: [Country]?, _ error: Error?) -> Void) {
        requestCountriesData(url: Endpoints.capital, queryParam: capital) { response, error in
            completion(response, error)
        }
    }
    
    func requestCountryByLanguage(language: String, completion: @escaping (_ response: [Country]?, _ error: Error?) -> Void) {
        requestCountriesData(url: Endpoints.language, queryParam: language) { response, error in
            completion(response, error)
        }
    }
    
    private func requestCountriesData(url: String, queryParam: String = "", completion: @escaping (_ response: [Country]?, _ error: Error?) -> Void) {
        Alamofire.request("\(url)\(queryParam)\(Endpoints.searchFilter)").responseJSON { response in
            
            guard response.result.isSuccess else {
                if let error = response.result.error {
                    os_log("Error while fetching country list: %@", log: OSLog.default, type: .error, "\(error)")
                    completion(nil, error)
                }
                
                return
            }
            
            guard let responseJSON = response.result.value as? [[String: Any]] else {
                if let httpResponse = response.result.value as? [String: Any],
                    let status = httpResponse["status"] as? Int, status == 404 {
                    completion([], nil)
                } else {
                    os_log("Invalid data received from the service", log: OSLog.default, type: .error)
                    os_log("data: %@", log: OSLog.default, type: .error, response.result.value.debugDescription)
                    completion(nil, FormatError.badFormatError)
                }
                return
            }
            
            var countries = [Country]()
            
            for data in responseJSON {
                if let country = Country(withJson: data) {
                    countries.append(country)
                }
            }
            
            if countries.count != responseJSON.count {
               completion(nil, FormatError.badFormatError)
            }
            
            completion(countries, nil)
        }
    }
}
