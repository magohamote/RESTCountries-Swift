//
//  Endpoints.swift
//  REST Countries Framework
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
