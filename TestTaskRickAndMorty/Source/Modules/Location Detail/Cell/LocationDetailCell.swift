//
//  LocationDetailCell.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 13.12.2021.
//

import UIKit

class LocationDetailCell: BaseUICollectionViewCell {
    private let characterImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let detailView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let detailViewStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.font = Font.sber(ofSize: Font.Size.eleven, weight: .regular)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: 0.07, .paragraphStyle: paragraphStyle])
        
        return label
    }()
    
    private let detailViewNameLabel: TopAlignedLabel = {
        let label = TopAlignedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = Font.sber(ofSize: Font.Size.seventeen, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.90

        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.numberOfLines = 0
        return label
    }()
    
    override func setupView() {
        [characterImageView, detailView].forEach { contentView.addSubview($0) }
        [detailViewStatusLabel, detailViewNameLabel].forEach { detailView.addSubview($0) }
        setupUI()
        cornerRadius = CharacterConstants.Layout.cornerRadius
    }
}
    //MARK: - UI
extension LocationDetailCell {
    private func setupUI() {
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterImageView.topAnchor.constraint(equalTo: topAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -79),
            
            detailView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            detailViewStatusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            detailViewStatusLabel.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 12),
            detailViewStatusLabel.heightAnchor.constraint(equalToConstant: 13),
            detailViewStatusLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -12),
            
            detailViewNameLabel.topAnchor.constraint(equalTo: detailViewStatusLabel.bottomAnchor),
            detailViewNameLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 12),
            detailViewNameLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -12),
            detailViewNameLabel.heightAnchor.constraint(equalToConstant: 42)
                        
        ])
    }
    //MARK: - Update with ViewModel
    func update(with viewModel: CharacterViewModel) {
        detailViewNameLabel.text = viewModel.name
        characterImageView.setImage(with: URL(string: viewModel.imageURL), isOffline: false)
        detailViewStatusLabel.text = "\(viewModel.status) - \(viewModel.species)"
    }
}
