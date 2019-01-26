//
//  FlagView.swift
//  REST Countries
//
//  Created by Cédric Rolland on 26.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit
import SVGKit

class FlagView: SVGKFastImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.anthracite.cgColor
    }
}
