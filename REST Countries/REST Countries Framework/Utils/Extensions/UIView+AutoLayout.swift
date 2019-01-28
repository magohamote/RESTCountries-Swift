//
//  UIView+AutoLayout.swift
//  REST Countries Framework
//
//  Created by Cédric Rolland on 25.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit

public extension UIView {
    func addSubview(_ view: UIView?, with constraints: [NSLayoutConstraint]?) {
        view?.translatesAutoresizingMaskIntoConstraints = false
        if let aView = view {
            addSubview(aView)
        }
        if let aConstraints = constraints {
            NSLayoutConstraint.activate(aConstraints)
        }
    }
}
