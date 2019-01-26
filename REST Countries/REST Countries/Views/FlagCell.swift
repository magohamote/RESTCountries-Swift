//
//  FlagCell.swift
//  REST Countries
//
//  Created by Cédric Rolland on 25.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit
import SVGKit

class FlagCell: UITableViewCell {
    
    @IBOutlet weak var flagView: FlagView?
    
    func config(with flagUrlString: String?) {
        if let flagUrlString = flagUrlString, let flagUrl = URL(string: flagUrlString) {
            flagView?.image = SVGKImage(contentsOf: flagUrl)
        }
    }
}
