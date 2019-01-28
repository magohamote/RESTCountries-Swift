//
//  Country.swift
//  REST Countries Framework
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import CoreLocation

public struct Country: Codable {
    public let name: String
    public let population: Int
    public let areaSize: Double?
    public let latitude: Double
    public let longitude: Double
    public let flag: String?
    public let capital: String?
    public let region: String?
    public var regionalBlocks: [RegionalBlock]?
    public var languages: [Language]?
    public var currencies: [Currency]?
    
    public init(name: String, population: Int, areaSize: Double?, latitude: Double, longitude: Double, flag: String?, capital: String?, region: String?) {
        self.name = name
        self.population = population
        self.areaSize = areaSize
        self.latitude = latitude
        self.longitude = longitude
        self.flag = flag
        self.capital = capital
        self.region = region
    }
}

public extension Country {
    public init?(withJson json: [String : Any]?) {
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

    public func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: CLLocation(latitude: self.latitude, longitude: self.longitude))
    }
}
