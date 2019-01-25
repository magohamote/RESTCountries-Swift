//
//  CountryCell.swift
//  REST Countries
//
//  Created by Cédric Rolland on 23.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit
import SVGKit

class CountryCell: UITableViewCell {
    
    @IBOutlet var countryView: UIView?
    @IBOutlet var flagView: SVGKImageView?
    @IBOutlet var countryNameLabel: UILabel?
    @IBOutlet var populationCountLabel: UILabel?
    @IBOutlet var areaSizeLabel: UILabel?
    
    func config(withCountry country: Country?) {
        if let flag = country?.flag, let flagUrl = URL(string: flag) {
            flagView?.image = SVGKImage(contentsOf: flagUrl)
            flagView?.contentMode = .scaleAspectFit
        }

        countryNameLabel?.text = country?.name
        populationCountLabel?.text = country?.population.formattedWithSeparator
        areaSizeLabel?.text = country?.areaSize.formattedWithSeparator
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        countryView?.layer.cornerRadius = 15
        countryView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        countryView?.layer.shadowRadius = 2
        countryView?.layer.shadowOpacity = 0.1
    }
}
