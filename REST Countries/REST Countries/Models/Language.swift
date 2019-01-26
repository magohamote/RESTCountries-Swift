//
//  Language.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import Foundation

struct Language: CountryData, Codable {
    var name: String
    let iso639_1: String
    
    static func getCountryData(json: [[String : Any]]?) -> [CountryData]? {
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
}

extension Language {
    init?(withJson json: [String : Any]?) {
        guard let name = json?["name"] as? String,
             let iso639_1 = json?["iso639_1"] as? String else {
                return nil
        }
        
        self.name = name
        self.iso639_1 = iso639_1
    }
}
