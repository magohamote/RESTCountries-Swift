//
//  AppDelegate.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController?
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            vc = storyboard.instantiateViewController(withIdentifier: CountryViewController.identifier) as? CountryViewController
        case .denied, .restricted, .notDetermined:
            vc = storyboard.instantiateViewController(withIdentifier: AskLocationPermissionViewController.identifier) as? AskLocationPermissionViewController
        }
        
        guard let safeVc = vc else {
            return true
        }
        
        let nav = NavigationController(rootViewController: safeVc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
}
