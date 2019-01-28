//
//  MockRequest.swift
//  REST CountriesTests
//
//  Created by Cédric Rolland on 27.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import Foundation

public class MockRequest {
    
    var request: String?
    
    struct response {
        static var data: HTTPURLResponse?
        static var json: AnyObject?
        static var error: NSError?
    }
    
    init (request: String) {
        self.request = request
    }
    
    public func responseJSON(options: JSONSerialization.ReadingOptions = .allowFragments, completionHandler: (NSURLRequest, HTTPURLResponse?, AnyObject?, NSError?) -> Void) -> Self {
        guard let request = request, let requestURL = NSURL(string: request) else {
            return self
        }
        
        completionHandler(NSURLRequest(url: requestURL as URL), MockRequest.response.data, MockRequest.response.json, MockRequest.response.error)
        return self
    }
}
