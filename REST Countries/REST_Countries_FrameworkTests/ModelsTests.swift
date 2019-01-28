//
//  ModelsTests.swift
//  REST CountriesTests
//
//  Created by Cédric Rolland on 27.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import XCTest
import Foundation
import CoreLocation

@testable import REST_Countries_Framework

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
    
    func testDistance() {
        guard let data = getTestData(name: "countries") else {
            XCTFail()
            return
        }
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]]
            var countries = [Country]()
            
            guard let jsonDataSafe = jsonData else {
                XCTFail()
                return
            }
            
            for data in jsonDataSafe {
                if let country = Country(withJson: data) {
                    countries.append(country)
                }
            }
            
            XCTAssertEqual(countries.count, 6)
            
            XCTAssertEqual(countries[0].name, "Algeria")
            XCTAssertEqual(countries[1].name, "Germany")
            XCTAssertEqual(countries[2].name, "Niger")
            XCTAssertEqual(countries[3].name, "Nigeria")
            XCTAssertEqual(countries[4].name, "Denmark")
            XCTAssertEqual(countries[5].name, "Norway")
            
            let myLocation = CLLocation(latitude: 51, longitude: 9)
            let sortedCountries = countries.sorted(by: {
                $0.distance(to: myLocation) < $1.distance(to: myLocation)
            })
            
            XCTAssertEqual(sortedCountries.count, 6)
            
            XCTAssertEqual(sortedCountries[0].name, "Germany")
            XCTAssertEqual(sortedCountries[1].name, "Denmark")
            XCTAssertEqual(sortedCountries[2].name, "Norway")
            XCTAssertEqual(sortedCountries[3].name, "Algeria")
            XCTAssertEqual(sortedCountries[4].name, "Niger")
            XCTAssertEqual(sortedCountries[5].name, "Nigeria")
            
        } catch {
            XCTFail()
        }
    }
}
