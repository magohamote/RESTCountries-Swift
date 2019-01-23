//
//  RegionalBlock.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import Foundation

struct RegionalBlock {
    let acronym: String
    let name: String
    let otherAcronyms: [String]
    let otherNames: [String]
}

extension RegionalBlock {
    init?(withJson json: [String : Any]?) {
        guard let acronym = json?["acronym"] as? String,
            let name = json?["name"] as? String,
            let otherAcronyms = json?["otherAcronyms"] as? [String],
            let otherNames = json?["otherNames"] as? [String] else {
                
                return nil
        }
        
        self.acronym = acronym
        self.name = name
        self.otherAcronyms = otherAcronyms
        self.otherNames = otherNames
    }
}
