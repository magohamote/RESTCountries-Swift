//
//  Currency.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import Foundation

struct Currency {
    let code: String
    let name: String
    let symbol: String
}

extension Currency {
    init?(withJson json: [String : Any]?) {
        guard let code = json?["code"] as? String,
            let name = json?["name"] as? String,
            let symbol = json?["symbol"] as? String else {
                
                return nil
        }
        
        self.code = code
        self.name = name
        self.symbol = symbol
    }
}
