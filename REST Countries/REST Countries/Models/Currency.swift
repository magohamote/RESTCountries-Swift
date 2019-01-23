//
//  Currency.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import Foundation

struct Currency {
    
    var code: String
    var name: String
    var symbol: String
    
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
