//
//  RegionalBlock.swift
//  REST Countries Framework
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

public struct RegionalBlock: CountryData, Codable {
    public var name: String
    
    public init(name: String){
        self.name = name
    }
    
    public static func getCountryData(json: [[String : Any]]?) -> [CountryData]? {
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

public extension RegionalBlock {
    public init?(withJson json: [String : Any]?) {
        guard let name = json?["name"] as? String else {
                return nil
        }
        
        self.name = name
    }
}
