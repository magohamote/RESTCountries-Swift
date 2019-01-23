//
//  LocationManager.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate {
    func locationManagerDidUpdate(_ locationManager: LocationManager, location: CLLocation)
}

class LocationManager: NSObject {
    
    var locationManagerDelegate: LocationManagerDelegate?
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.delegate = self
        manager.allowsBackgroundLocationUpdates = true
        manager.requestAlwaysAuthorization()
        return manager
    }()
    
    override init() {
        super.init()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else {
            return
        }

        locationManagerDelegate?.locationManagerDidUpdate(self, location: mostRecentLocation)
    }
}
