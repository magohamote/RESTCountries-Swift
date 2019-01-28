//
//  CountryData.swift
//  REST Countries Framework
//
//  Created by Cédric Rolland on 26.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

public protocol CountryData {
    var name: String { get }
    static func getCountryData(json: [[String: Any]]?) -> [CountryData]?
}
