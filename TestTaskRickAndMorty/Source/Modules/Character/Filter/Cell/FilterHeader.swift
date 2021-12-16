//
//  FilterHeader.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 15.12.2021.
//

import UIKit

class FilterHeader: BaseUITableViewHeaderFooterView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.grayTabBar
        label.font = Font.sber(ofSize: Font.Size.fithteen, weight: .regular)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: -0.24, .paragraphStyle: paragraphStyle])
        return label
    }()
    
    override func setupView() {
        contentView.addSubview(label)
        setupUI()
    }
}
    //MARK: - UI
extension FilterHeader {
    private func setupUI() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9.5)
        ])
    }
    //MARK: - Update
    func update(someText text: String) {
        label.text = text
    }
}
