//
//  MockService.swift
//  REST CountriesTests
//
//  Created by Cédric Rolland on 27.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import Foundation
import Alamofire

@testable import REST_Countries

class MockService: Service {
    
    private var htmlResponse = HTTPURLResponse(url: NSURL(string: "dummyURL")! as URL, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)
    
    override func requestMyCountry(countryName: String, completion: @escaping ([Country]?, Error?) -> Void) {
        request(completion: completion)
    }
    
    override func requestAllCountries(completion: @escaping ([Country]?, Error?) -> Void) {
        request(completion: completion)
    }
    
    override func requestCountryByCapital(capital: String, completion: @escaping ([Country]?, Error?) -> Void) {
        request(completion: completion)
    }
    
    override func requestCountryByLanguage(language: String, completion: @escaping ([Country]?, Error?) -> Void) {
        request(completion: completion)
    }
    
    override func requestCountryByName(countryName: String, filter: String, completion: @escaping ([Country]?, Error?) -> Void) {
        request(completion: completion)
    }
    
    private func request(completion: @escaping ([Country]?, Error?) -> Void) {
        let name = "my_country"
        
        guard let data = getTestData(name: name) else {
            return
        }
        
        MockRequest.response.data = htmlResponse
        
        do {
            MockRequest.response.json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            completion(nil, FormatError.badFormatError)
            return
        }
        
        _ = request("dummyURL").responseJSON { (request, response, JSON, error) -> Void in
            if let jsonData = JSON as? [[String: Any]] {
                var countries = [Country]()
                
                for data in jsonData {
                    if let country = Country(withJson: data) {
                        countries.append(country)
                    }
                }
                
                completion(countries, nil)
            } else {
                completion(nil, FormatError.badFormatError)
            }
        }
    }
    
    private func request(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil) -> MockRequest {
        
        guard let url = url as? String else {
            return MockRequest(request: "")
        }
        
        return MockRequest(request: url)
    }
    
    private func getTestData(name: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: name, ofType: "json") else {
            return nil
        }
        
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
    }
}
