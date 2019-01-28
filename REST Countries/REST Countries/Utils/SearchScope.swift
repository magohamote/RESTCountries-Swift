//
//  SearchScope.swift
//  REST Countries
//
//  Created by Cédric Rolland on 28.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

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
