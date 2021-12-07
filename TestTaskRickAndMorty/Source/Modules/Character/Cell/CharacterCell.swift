//
//  CharacterCell.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 05.12.2021.
//

import UIKit

class CharacterCell: BaseUICollectionViewCell {
     lazy var characterImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override func setupView() {
        contentView.addSubview(characterImageView)
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
            characterImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
//MARK: - Update with ViewModel
    func update(with viewModel: CharacterViewModel) {
        characterImageView.setImage(with: URL(string: viewModel.imageURL))
    }
}

