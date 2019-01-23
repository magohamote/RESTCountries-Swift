//
//  CountryCell.swift
//  REST Countries
//
//  Created by Cédric Rolland on 23.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit
import SwiftSVG

class CountryCell: UITableViewCell {
    
    @IBOutlet var countryView: UIView?
    @IBOutlet var flagView: UIView?
    @IBOutlet var countryNameLabel: UILabel?
    @IBOutlet var populationCountLabel: UILabel?
    @IBOutlet var areaSizeLabel: UILabel?
    
    func config(withCountry country: Country?) {
//        if let flag = country?.flag, let flagUrl = URL(string: flag) {
//            CALayer(SVGURL: flagUrl) { [weak self] svgLayer in
//                svgLayer.resizeToFit(self?.flagView?.bounds ?? .zero)
//                self?.flagView?.layer.addSublayer(svgLayer)
//            }
//        }

        flagView?.contentMode = .scaleAspectFill
        countryNameLabel?.text = country?.name
        populationCountLabel?.text = country?.population.formattedWithSeparator
        areaSizeLabel?.text = country?.areaSize.formattedWithSeparator
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        flagView?.layer.cornerRadius = (flagView?.bounds.height ?? 0) / 2
        flagView?.layer.masksToBounds = true
        
        countryView?.layer.cornerRadius = 15
        countryView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        countryView?.layer.shadowRadius = 2
        countryView?.layer.shadowOpacity = 0.1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        flagView?.layer.sublayers?.removeAll()
    }
}
