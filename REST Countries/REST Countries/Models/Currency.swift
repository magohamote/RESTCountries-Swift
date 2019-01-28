//
//  Currency.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

struct Currency: CountryData, Codable {
    var name: String
    let symbol: String
    
    static func getCountryData(json: [[String : Any]]?) -> [CountryData]? {
        guard let json = json else {
            return nil
        }
        
        var currencies = [Currency]()
        
        for data in json {
            if let currency = Currency(withJson: data) {
                currencies.append(currency)
            }
        }
        
        return currencies.count > 0 ? currencies : nil
    }
}

extension Currency {
    init?(withJson json: [String : Any]?) {
        guard let name = json?["name"] as? String,
            let symbol = json?["symbol"] as? String else {
                return nil
        }

        self.name = name
        self.symbol = symbol
    }
}
