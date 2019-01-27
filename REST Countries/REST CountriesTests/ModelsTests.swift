//
//  ModelsTests.swift
//  REST CountriesTests
//
//  Created by Cédric Rolland on 27.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import XCTest
import Foundation
@testable import REST_Countries

class ModelsTests: XCTestCase {
    
    // MARK: - Language Model
    
    func testSuccesfulLanguageJsonInit() {
        guard let data = getTestData(name: "languages") else {
            XCTFail()
            return
        }
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            XCTAssertNotNil(Language(withJson: jsonData))
        } catch {
            XCTFail()
        }
    }

    func testFailingLanguageJsonInit() {
        guard let data = getTestData(name: "bad_data") else {
            XCTFail()
            return
        }

        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            XCTAssertNil(Language(withJson: jsonData))
        } catch {
            XCTFail()
        }
    }

    
    // MARK: - Currency Model

    func testSuccesfulCurrencyJsonInit() {
        guard let data = getTestData(name: "currency") else {
            XCTFail()
            return
        }

        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            XCTAssertNotNil(Currency(withJson: jsonData))
        } catch {
            XCTFail()
        }
    }

    func testFailingCurrencyJsonInit() {
        guard let data = getTestData(name: "bad_data") else {
            XCTFail()
            return
        }

        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            XCTAssertNil(Currency(withJson: jsonData))
        } catch {
            XCTFail()
        }
    }
    
    
    // MARK: - RegionalBlock Model
    
    func testSuccesfulRegionalBlockJsonInit() {
        guard let data = getTestData(name: "regional_block") else {
            XCTFail()
            return
        }
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            XCTAssertNotNil(RegionalBlock(withJson: jsonData))
        } catch {
            XCTFail()
        }
    }
    
    func testFailingRegionalBlockJsonInit() {
        guard let data = getTestData(name: "bad_data") else {
            XCTFail()
            return
        }
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            XCTAssertNil(RegionalBlock(withJson: jsonData))
        } catch {
            XCTFail()
        }
    }
    
    
    // MARK: - Country Model
    
    func testSuccesfulCountryJsonInit() {
        guard let data = getTestData(name: "country") else {
            XCTFail()
            return
        }
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            XCTAssertNotNil(Country(withJson: jsonData))
        } catch {
            XCTFail()
        }
    }
    
    func testFailingCountryJsonInit() {
        guard let data = getTestData(name: "bad_data") else {
            XCTFail()
            return
        }
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            XCTAssertNil(Country(withJson: jsonData))
        } catch {
            XCTFail()
        }
    }
}
