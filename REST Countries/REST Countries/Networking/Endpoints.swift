//
//  Endpoints.swift
//  REST Countries
//
//  Created by Cédric Rolland on 23.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import Foundation

struct Endpoints {
    static let all = "https://restcountries.eu/rest/v2/all"
    static let name = "https://restcountries.eu/rest/v2/name/"
    static let capital = "https://restcountries.eu/rest/v2/capital/"
    static let language = "https://restcountries.eu/rest/v2/lang/"
    static let searchFilter = "?fields=name;flag;population;area;latlng"
    static let currentCountryFilter = "?fields=name;flag;population;capital;region;regionalBlocs;languages;currencies;latlng"
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
