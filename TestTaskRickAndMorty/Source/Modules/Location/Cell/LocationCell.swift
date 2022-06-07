//
//  LocationCell.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 11.12.2021.
//

import UIKit

final class LocationCell: BaseUICollectionViewCell {
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        label.font = Font.sber(ofSize: Font.Size.eleven, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: 0.07, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.numberOfLines = 0
        return label
    }()
    
    private let nameLabel: TopAlignedLabel = {
        let label = TopAlignedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = Font.sber(ofSize: Font.Size.seventeen, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.90

        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.numberOfLines = 0
        return label
    }()
    
    override func setupView() {
        [typeLabel, nameLabel].forEach { contentView.addSubview($0) }
        setupUI()
        cornerRadius = LocationConstants.Layout.cornerRadius
        shadowRadius = LocationConstants.Layout.shadowRadius
    }
}
    //MARK: - UI
extension LocationCell {
    private func setupUI() {
        NSLayoutConstraint.activate([
            typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            typeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            nameLabel.heightAnchor.constraint(equalToConstant: 43)
        ])
    }
    //MARK: - Update with ViewModel
    func update(with viewModel: LocationViewModel) {
        typeLabel.text = viewModel.type
        nameLabel.text = viewModel.name
    }
}
