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
            // This svg is malformed and makes the SVGKit library crash
            // (SwiftSVG is even worse than SVGKit)
            if flag != "https://restcountries.eu/data/shn.svg" {
                self.flagView?.image = SVGKImage(contentsOf: flagUrl)
            }
            flagView?.layer.borderColor = UIColor.lightGray.cgColor
            flagView?.layer.borderWidth = 0.5
        }

        countryNameLabel?.text = country?.name
        populationCountLabel?.text = country?.population.formattedWithSeparator
        areaSizeLabel?.text = "\(country?.areaSize?.formattedWithSeparator ?? "Unknown") km\u{00B2}"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        countryView?.layer.cornerRadius = 15
        countryView?.layer.shadowOffset = CGSize(width: 0, height: 0)
        countryView?.layer.shadowRadius = 2
        countryView?.layer.shadowOpacity = 0.1
    }
}
