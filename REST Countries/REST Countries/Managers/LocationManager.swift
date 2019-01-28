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
    func locationManagerGotCurrentCity(_ locationManager: LocationManager)
}

class LocationManager: NSObject {
    
    weak var locationManagerDelegate: LocationManagerDelegate?
    var myCountryName: String?
    var myLocation: CLLocation? {
        didSet {
            getCity()
        }
    }
    
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
        geoCoder.reverseGeocodeLocation(myLocation, completionHandler: { [unowned self] placemarks, error -> Void in

            // The https://restcountries.eu works only with english country names. My phone is in french, so
            // placemarks?.first?.country will return "Allemagne" instead of "Germany" in my case.
            // This guarantee that the country name will always be in english regardless of the
            // language of the phone.
            let countryCode = placemarks?.first?.isoCountryCode
            guard let dictionary = [NSLocale.Key.countryCode.rawValue : countryCode] as? [String : String] else {
                return
            }

            let identifier = NSLocale.localeIdentifier(fromComponents: dictionary)
            let countryName = NSLocale(localeIdentifier: "en_US").displayName(forKey: .identifier, value: identifier)

            self.myCountryName = countryName
            self.locationManagerDelegate?.locationManagerGotCurrentCity(self)
        })
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let lastLocation = locations.last else {
            return
        }
        
        if (myLocation == nil || lastLocation.distance(from: (myLocation ?? lastLocation)) > 1000) && Reachability.isConnected() {
            myLocation = lastLocation
            locationManagerDelegate?.locationManagerDidUpdate(self)
        }
    }
}
