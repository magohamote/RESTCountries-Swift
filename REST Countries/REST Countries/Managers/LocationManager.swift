//
//  LocationManager.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func locationManagerDidUpdate(_ locationManager: LocationManager)
}

class LocationManager: NSObject {
    
    var myLocation: CLLocation? {
        didSet {
            getCity()
        }
    }
    
    var myCountryName: String?
    
    weak var locationManagerDelegate: LocationManagerDelegate?
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    override init() {
        super.init()
        locationManager.startUpdatingLocation()
    }
    
    private func getCity() {
        guard let myLocation = myLocation else {
            return
        }
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(myLocation, completionHandler: { placemarks, error -> Void in
            guard let placeMark = placemarks?.first,
                let countryName = placeMark.country else {
                return
            }

            self.myCountryName = countryName
        })
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let lastLocation = locations.last else {
            return
        }
        
        if myLocation == nil || lastLocation.distance(from: (myLocation ?? lastLocation)) > 1000 {
            self.myLocation = lastLocation
            locationManagerDelegate?.locationManagerDidUpdate(self)
        }
    }
}
