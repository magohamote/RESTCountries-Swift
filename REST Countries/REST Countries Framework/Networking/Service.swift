//
//  Service.swift
//  REST Countries
//
//  Created by Cédric Rolland on 23.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import os.log

public class Service {
    
    public init() {}

    typealias countryCompletion = (_ response: [Country]?, _ error: Error?) -> Void
    
    func requestMyCountry(countryName: String, completion: @escaping countryCompletion) {
        requestCountriesData(url: Endpoints.name, queryParam: countryName, filter: Endpoints.currentCountryFilter) { response, error in
            completion(response, error)
        }
    }
    
    func requestAllCountries(completion: @escaping countryCompletion) {
        requestCountriesData(url: Endpoints.all) { response, error in
            completion(response, error)
        }
    }
    
    func requestCountryByName(countryName: String, completion: @escaping countryCompletion) {
        requestCountriesData(url: Endpoints.name, queryParam: countryName) { response, error in
            completion(response, error)
        }
    }
    
    func requestCountryByCapital(capital: String, completion: @escaping countryCompletion) {
        requestCountriesData(url: Endpoints.capital, queryParam: capital) { response, error in
            completion(response, error)
        }
    }
    
    func requestCountryByLanguage(language: String, completion: @escaping countryCompletion) {
        requestCountriesData(url: Endpoints.language, queryParam: language) { response, error in
            completion(response, error)
        }
    }
    
    private func requestCountriesData(url: String, queryParam: String = "",
                                      filter: String = Endpoints.searchFilter,
                                      completion: @escaping (_ response: [Country]?, _ error: Error?) -> Void) {
        
        guard let urlSafe = URL(string: "\(url)\(queryParam)\(filter)") else {
            os_log("Error: invalid url: %@", log: OSLog.default, type: .error, "\(url)\(queryParam)\(filter)")
            completion(nil, RequestError.badFormatURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlSafe) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(nil, RequestError.noResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                if response.statusCode == 404 {
                    os_log("No country matching the request was found", log: OSLog.default, type: .error)
                    completion([], nil)
                } else {
                    os_log("Unexpected response from the API: %@", log: OSLog.default, type: .error, response.debugDescription)
                    completion(nil, RequestError.invalidResponse)
                }
                return
            }
            
            guard let dataSafe = data else {
                os_log("Unexpected data from the API: %@", log: OSLog.default, type: .error, data.debugDescription)
                completion(nil, RequestError.invalidData)
                return
            }
            
            do {
                guard let responseJSON = try JSONSerialization.jsonObject(with: dataSafe, options: []) as? [[String: Any]] else {
                    os_log("Unexpected data format from the API: %@", log: OSLog.default, type: .error, dataSafe.debugDescription)
                    completion(nil, RequestError.invalidData)
                    return
                }
                
                var countries = [Country]()
                
                for data in responseJSON {
                    if let country = Country(withJson: data) {
                        countries.append(country)
                    }
                }
                
                completion(countries, nil)
            } catch let error {
                os_log("Unexpected error during JSONSerialization: %@", log: OSLog.default, type: .error, error.localizedDescription)
                completion(nil, error)
            }
        }
        
        task.resume()
    }
}
