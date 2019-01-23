//
//  Language.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import Foundation

struct Language {
    let iso639_1: String
    let iso639_2: String
    let name: String
    let nativeName: String
}

extension Language {
    init?(withJson json: [String : Any]?) {
        guard let iso639_1 = json?["iso639_1"] as? String,
            let iso639_2 = json?["iso639_2"] as? String,
            let name = json?["name"] as? String,
            let nativeName = json?["nativeName"] as? String else {
                
                return nil
        }
        
        self.iso639_1 = iso639_1
        self.iso639_2 = iso639_2
        self.name = name
        self.nativeName = nativeName
    }
}
