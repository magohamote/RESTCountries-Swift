//
//  XCTestCase+GetTestData.swift
//  REST CountriesTests
//
//  Created by Cédric Rolland on 27.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    func getTestData(name: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: name, ofType: "json") else {
            return nil
        }
        
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
    }
}
