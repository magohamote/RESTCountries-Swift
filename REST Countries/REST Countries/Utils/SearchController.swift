//
//  SearchController.swift
//  REST Countries
//
//  Created by Cédric Rolland on 23.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit

class SearchController: UISearchController {
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.scopeButtonTitles = SearchScope.allCases.map { $0.rawValue }
        searchBar.tintColor = .white
        searchBar.barStyle = .blackTranslucent
        obscuresBackgroundDuringPresentation = false
        searchBar.placeholder = "Search countries"
    }
}
