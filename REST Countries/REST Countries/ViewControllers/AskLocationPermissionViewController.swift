//
//  AskLocationPermissionViewController.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit
import CoreLocation

class AskLocationPermissionViewController: UIViewController {

    @IBOutlet weak var acceptPermissionButton: RoundButton?
    
    private let locationManager = CLLocationManager()
    private let status  = CLLocationManager.authorizationStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        navigationController?.isNavigationBarHidden = true
        
        switch status {
        case .denied, .restricted:
            updateEnableButtonToSettings()
            
        case .notDetermined:
            acceptPermissionButton?.addTarget(self, action: #selector(askLocationPermission(_:)), for: .touchUpInside)
            
        default:
            pushCountryViewController(false)
        }
    }

    private func updateEnableButtonToSettings() {
        acceptPermissionButton?.setTitle("Open settings", for: .normal)
        acceptPermissionButton?.removeTarget(self, action: #selector(askLocationPermission(_:)), for: .touchUpInside)
        acceptPermissionButton?.addTarget(self, action: #selector(openSettings(_:)), for: .touchUpInside)
    }
    
    @objc private func openSettings(_ sender: UIButton) {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }
    
    @objc private func askLocationPermission(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
    }
    
    @objc private func pushCountryViewController(_ animated: Bool) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: CountryViewController.identifier) as? CountryViewController else {
            return
        }
        
        navigationController?.pushViewController(vc, animated: animated)
    }
}

extension AskLocationPermissionViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted:
            updateEnableButtonToSettings()
        case .authorizedWhenInUse, .authorizedAlways:
            pushCountryViewController(true)
        default:
            return
        }
    }
}
