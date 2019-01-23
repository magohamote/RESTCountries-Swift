//
//  Country.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import Foundation

struct Country {
    
    var name: String
    var population: Int
    var areaSize: Double
    var flag: String?
    var capital: String?
    var region: String?
    var regionalBlock: RegionalBlock?
    var languages: [Language]?
    var currencies: [Currency]?
    
    init?(withJson json: [String : Any]?) {
        guard let name = json?["name"] as? String,
            let areaSize = json?["area"] as? Double,
            let population = json?["population"] as? Int else {
                return nil
        }
        
        self.name = name
        self.areaSize = areaSize
        self.population = population
        
        self.flag = json?["flag"] as? String
        self.capital = json?["capital"] as? String
        self.region = json?["region"] as? String
        self.regionalBlock = RegionalBlock(withJson: json?["regionalBlocs"] as? [String: Any])
        
        self.languages = getLanguages(json: json?["languages"] as? [[String: Any]])
        self.currencies = getCurrencies(json: json?["currencies"] as? [[String: Any]])
    }
    
    private func getLanguages(json: [[String: Any]]?) -> [Language]? {
        guard let json = json else {
            return nil
        }
        
        var languages = [Language]()
        
        for data in json {
            if let language = Language(withJson: data) {
                languages.append(language)
            }
        }
        
        return languages.count > 0 ? languages : nil
    }
    
    private func getCurrencies(json: [[String: Any]]?) -> [Currency]? {
        guard let json = json else {
            return nil
        }
        
        var currencies = [Currency]()
        
        for data in json {
            if let currency = Currency(withJson: data) {
                currencies.append(currency)
            }
        }
        
        return currencies.count > 0 ? currencies : nil
    }
}
