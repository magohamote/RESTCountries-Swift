//
//  LocationPermissionManager.swift
//  REST Countries
//
//  Created by Cédric Rolland on 23.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit
import CoreLocation

class LocationPermissionManager: NSObject {
    
    private let status  = CLLocationManager.authorizationStatus()
    
    func checkPermission(_ vc: UIViewController) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            return
            
        case .denied, .restricted, .notDetermined:
            askPermission(vc)
        }
    }
    
    private func askPermission(_ vc: UIViewController) {
        guard let askLocationPermissionVC = vc.storyboard?.instantiateViewController(withIdentifier: AskLocationPermissionViewController.identifier) as? AskLocationPermissionViewController else {
            return
        }
        
        vc.present(askLocationPermissionVC, animated: false, completion: nil)
    }
}
