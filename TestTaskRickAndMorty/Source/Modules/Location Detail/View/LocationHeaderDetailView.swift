//
//  LocationHeaderDetailView.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 12.12.2021.
//

import UIKit

class LocationHeaderDetailView: BaseUICollectionReusableView {
    
    private let label: TopAlignedLabel = {
        let label = TopAlignedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.grayTabBar
        label.font = Font.sber(ofSize: Font.Size.twenty, weight: .bold)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: 0.38, .paragraphStyle: paragraphStyle])
        return label
    }()
    
    override func setupView() {
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.heightAnchor.constraint(equalTo: heightAnchor),
            label.widthAnchor.constraint(equalToConstant: 298)
        ])
    }
    
    func update(some text: String) {
        label.text = text
    }
}
