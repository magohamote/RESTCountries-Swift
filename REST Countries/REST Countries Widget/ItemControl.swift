//
//  ItemControl.swift
//  REST Countries Widget
//
//  Created by Cédric Rolland on 26.01.19.
//  Copyright © 2019 Cédric Rolland. All rights reserved.
//

import UIKit

class ItemSelectionControl: UIControl {
    
    var items: [String] = [] {
        didSet {
            updateItems()
        }
    }
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private var labels: [UILabel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.isUserInteractionEnabled = false
        
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.addSubview(stackView, with: [
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        addSubview(scrollView, with: [
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func updateItems() {
        for view in labels {
            view.removeFromSuperview()
        }
        
        labels = items.map { createButton(for: $0) }
        for label in labels {
            stackView.addArrangedSubview(label)
        }
    }
    
    private func createButton(for itemTitle: String) -> UILabel {
        let label = UILabel()
        label.text = itemTitle
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .anthracite
        return label
    }
}
