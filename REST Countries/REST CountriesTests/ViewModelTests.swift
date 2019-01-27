//
//  ViewModelTests.swift
//  REST CountriesTests
//
//  Created by Cédric Rolland on 27.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import XCTest
import Foundation
import Alamofire
@testable import REST_Countries

class ViewModelTests: XCTestCase, CountryViewModelDelegate {
    
    var countryViewModel: CountryViewModel?
    
    override func setUp() {
        super.setUp()
        
        countryViewModel = CountryViewModel(service: MockService())
        countryViewModel?.delegate = self
    }
    
    override func tearDown() {
        countryViewModel = nil
        super.tearDown()
    }
    
    // MARK: - Country View Model
    
    func testUserViewModel() {
        countryViewModel?.requestMyCountry(countryName: "")
        countryViewModel?.requestAllCountries()
        countryViewModel?.requestCountriesByCapital(capital: "")
        countryViewModel?.requestCountriesByName(countryName: "")
        countryViewModel?.requestCountriesByLanguage(language: "")
    }
    
    func didReceiveCountries(countries: [Country]) {
        XCTAssertNotNil(countries)
        XCTAssertEqual(countries.count, 1)
        XCTAssertEqual(countries.first?.name, "Switzerland")
        XCTAssertEqual(countries.first?.population, 1)
        XCTAssertEqual(countries.first?.areaSize, 1)
        XCTAssertEqual(countries.first?.latitude, 1)
        XCTAssertEqual(countries.first?.longitude, 1)
        XCTAssertEqual(countries.first?.flag, "flag")
        XCTAssertEqual(countries.first?.capital, "Bern")
        XCTAssertEqual(countries.first?.region, "Europe")
        XCTAssertEqual(countries.first?.regionalBlocks?.count, 1)
        XCTAssertEqual(countries.first?.languages?.count, 3)
        XCTAssertEqual(countries.first?.currencies?.count, 1)
    }
    
    func didFailDownloadCountries(error: Error) {
        XCTAssertNil(error)
    }
}
