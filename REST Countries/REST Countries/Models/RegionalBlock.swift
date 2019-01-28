//
//  RegionalBlock.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

struct RegionalBlock: CountryData, Codable {
    var name: String
    
    static func getCountryData(json: [[String : Any]]?) -> [CountryData]? {
        guard let json = json else {
            return nil
        }
        
        var regionalBlocks = [RegionalBlock]()
        
        for data in json {
            if let regionalBlock = RegionalBlock(withJson: data) {
                regionalBlocks.append(regionalBlock)
            }
        }
        
        return regionalBlocks.count > 0 ? regionalBlocks : nil
    }
}

extension RegionalBlock {
    init?(withJson json: [String : Any]?) {
        guard let name = json?["name"] as? String else {
                return nil
        }
        
        self.name = name
    }
}
