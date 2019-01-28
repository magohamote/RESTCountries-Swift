//
//  Endpoints.swift
//  REST Countries
//
//  Created by Cédric Rolland on 23.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

struct Endpoints {
    private static let baseURL = "https://restcountries.eu/rest/v2/"
    static let all = "\(baseURL)all"
    static let name = "\(baseURL)name/"
    static let capital = "\(baseURL)capital/"
    static let language = "\(baseURL)lang/"
    static let searchFilter = "?fields=name;flag;population;area;latlng"
    static let currentCountryFilter = "?fields=name;flag;population;capital;region;regionalBlocs;languages;currencies;latlng;area"
}

enum SearchScope: String, CaseIterable {
    case name = "Name"
    case capital = "Capital"
    case language = "Language"
    
    init?(id : Int) {
        switch id {
            case 0: self = .name
            case 1: self = .capital
            case 2: self = .language
            default: return nil
        }
    }
}
