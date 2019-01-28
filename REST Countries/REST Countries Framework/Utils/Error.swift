//
//  Error.swift
//  REST Countries Framework
//
//  Created by Cédric Rolland on 28.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

public enum RequestError: Error {
    case badFormatURL
    case noResponse
    case invalidResponse
    case invalidData
}
