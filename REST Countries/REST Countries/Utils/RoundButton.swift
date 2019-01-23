//
//  RoundButton.swift
//  REST Countries
//
//  Created by Cédric Rolland on 22.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        layer.cornerRadius = bounds.height / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.turquoise.cgColor
    }
}
