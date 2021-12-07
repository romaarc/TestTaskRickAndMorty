//
//  CharacterCell.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 05.12.2021.
//

import UIKit

class CharacterCell: BaseUICollectionViewCell {
    private let characterImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let detailView: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let detailViewNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .natural
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.font = Font.sber(ofSize: Font.Size.fouthteen, weight: .bold)
        return label
    }()
    
    private let detailViewStatusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Localize.Images.statusSymbol
        return imageView
    }()
    
    private let detailViewStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .natural
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.font = Font.sber(ofSize: Font.Size.ten, weight: .regular)
        return label
    }()
    
    override func setupView() {
        [characterImageView, detailView].forEach { contentView.addSubview($0) }
        [detailViewNameLabel, detailViewStatusImageView, detailViewStatusLabel].forEach { detailView.addSubview($0) }
        
        setupUI()
        
        shadowColor = CharacterConstants.Design.shadowColor
        cornerRadius = CharacterConstants.Layout.cornerRadius
        shadowRadius = CharacterConstants.Layout.shadowRadius
        shadowOpacity = CharacterConstants.Layout.shadowOpacity
        shadowOffsetWidth = CharacterConstants.Layout.shadowOffsetWidth
        shadowOffsetHeight = CharacterConstants.Layout.shadowOffsetHeight
    }
}

//MARK: - UI
extension CharacterCell {
    private func setupUI() {
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterImageView.topAnchor.constraint(equalTo: topAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            
            detailView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            detailViewNameLabel.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 8),
            detailViewNameLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 8),
            detailViewNameLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -8),
            detailViewNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            detailViewStatusImageView.topAnchor.constraint(equalTo: detailViewNameLabel.bottomAnchor, constant: 5),
            detailViewStatusImageView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 8),
            detailViewStatusImageView.heightAnchor.constraint(equalToConstant: 8),
            detailViewStatusImageView.widthAnchor.constraint(equalToConstant: 8),
            
            detailViewStatusLabel.leadingAnchor.constraint(equalTo: detailViewStatusImageView.trailingAnchor, constant: 5),
            detailViewStatusLabel.topAnchor.constraint(equalTo: detailViewNameLabel.bottomAnchor, constant: 2)
        ])
    }
    //MARK: - Update with ViewModel
    func update(with viewModel: CharacterViewModel) {
        detailViewNameLabel.text = viewModel.name
        characterImageView.setImage(with: URL(string: viewModel.imageURL))
        detailViewStatusImageView.tintColor = viewModel.status == "Alive" ? .green : (viewModel.status == "Dead" ? .red : .gray)
        detailViewStatusLabel.text = "\(viewModel.status) - \(viewModel.species)"
    }
}

