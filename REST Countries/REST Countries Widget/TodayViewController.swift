//
//  TodayViewController.swift
//  REST Countries Widget
//
//  Created by Cédric Rolland on 26.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit
import NotificationCenter
import SVGKit

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var flagView: FlagView?
    @IBOutlet weak var countryNameLabel: UILabel?
    @IBOutlet weak var capitalLabel: UILabel?
    @IBOutlet weak var populationLabel: UILabel?
    @IBOutlet weak var regionLabel: UILabel?
    @IBOutlet weak var regionalBlocksControl: ItemSelectionControl?
    @IBOutlet weak var languagesControl: ItemSelectionControl?
    @IBOutlet weak var currenciesControl: ItemSelectionControl?
    
    private var myCountry: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        let sharedDefaults = UserDefaults.init(suiteName: SharedUserDefaults.suiteName)
        if let data = sharedDefaults?.value(forKey:"myCountry") as? Data {
            myCountry = try? PropertyListDecoder().decode(Country.self, from: data)
            
            guard let myCountry = myCountry else {
                completionHandler(NCUpdateResult.failed)
                return
            }
            
            updateUI(myCountry: myCountry)
            completionHandler(NCUpdateResult.newData)
        }
        
        completionHandler(NCUpdateResult.failed)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            preferredContentSize = maxSize
        } else if activeDisplayMode == .expanded {
            preferredContentSize = CGSize(width: maxSize.width, height: 325)
        }
    }
    
    private func updateUI(myCountry: Country) {
        if let flag = myCountry.flag, let flagUrl = URL(string: flag) {
            flagView?.image = SVGKImage(contentsOf: flagUrl)
        }
        
        countryNameLabel?.text = myCountry.name
        capitalLabel?.text = myCountry.capital
        populationLabel?.text = String(myCountry.population.formattedWithSeparator)
        regionLabel?.text = myCountry.region
        regionalBlocksControl?.items = (myCountry.regionalBlocks ?? [RegionalBlock]()).map { $0.name }
        languagesControl?.items = (myCountry.languages ?? [Language]()).map { $0.name }
        currenciesControl?.items = (myCountry.currencies ?? [Currency]()).map { "\($0.name) - \($0.symbol)" }
    }
}
