//
//  Country.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import Foundation
import CoreLocation

struct Country {
    let name: String
    let population: Int
    let areaSize: Double
    let latitude: Double
    let longitude: Double
    let flag: String?
    let capital: String?
    let region: String?
    var regionalBlocks: [RegionalBlock]?
    var languages: [Language]?
    var currencies: [Currency]?
}

extension Country {
    init?(withJson json: [String : Any]?) {
        guard let name = json?["name"] as? String,
            let areaSize = json?["area"] as? Double,
            let population = json?["population"] as? Int,
            let latlng = json?["latlng"] as? [Double],
            let latitude = latlng[safe: 0],
            let longitude = latlng[safe: 1] else {
                return nil
        }
        
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.areaSize = areaSize
        self.population = population
        
        self.flag = json?["flag"] as? String
        self.capital = json?["capital"] as? String
        self.region = json?["region"] as? String
        
        self.regionalBlocks = getRegionalBlocks(json: json?["regionalBlocs"] as? [[String: Any]])
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
    
    private func getRegionalBlocks(json: [[String: Any]]?) -> [RegionalBlock]? {
        guard let json = json else {
            return nil
        }
        
        var regionalBlocks = [RegionalBlock]()
        
        for data in json {
            if let regionalBlock = RegionalBlock(withJson: data) {
                regionalBlocks.append(regionalBlock)
            }
        }
        
        return regionalBlocks.count > 0 ? regionalBlocks : nil
    }
    
    func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: CLLocation(latitude: self.latitude, longitude: self.longitude))
    }
}
