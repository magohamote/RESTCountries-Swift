//
//  Country.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import Foundation
import CoreLocation

struct Country: Codable {
    let name: String
    let population: Int
    let areaSize: Double?
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
            let population = json?["population"] as? Int,
            let latlng = json?["latlng"] as? [Double],
            let latitude = latlng[safe: 0],
            let longitude = latlng[safe: 1] else {
                return nil
        }
        
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.population = population
        
        self.areaSize = json?["area"] as? Double
        self.flag = json?["flag"] as? String
        self.capital = json?["capital"] as? String
        self.region = json?["region"] as? String
        
        self.regionalBlocks = RegionalBlock.getCountryData(json: json?["regionalBlocs"] as? [[String: Any]]) as? [RegionalBlock]
        self.languages = Language.getCountryData(json: json?["languages"] as? [[String: Any]]) as? [Language]
        self.currencies = Currency.getCountryData(json: json?["currencies"] as? [[String: Any]]) as? [Currency]
    }

    func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: CLLocation(latitude: self.latitude, longitude: self.longitude))
    }
}
