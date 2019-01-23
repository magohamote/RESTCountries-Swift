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
        
        // background of Navigation Controller is visible during transition
        // so I changed the color to match the rest
        let win = UIApplication.shared.delegate?.window
        win??.backgroundColor = .white
        
        navigationBar.barTintColor = .turquoise
        navigationBar.isTranslucent = false
        navigationBar.prefersLargeTitles = true
        navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
    }
}
