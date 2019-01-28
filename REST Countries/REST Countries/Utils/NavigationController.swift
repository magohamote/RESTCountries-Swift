//
//  NavigationController.swift
//  REST Countries
//
//  Created by Cédric Rolland on 23.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        
        navigationBar.barTintColor = .turquoise
        navigationBar.isTranslucent = false
        navigationBar.prefersLargeTitles = true
        navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
    }
}
