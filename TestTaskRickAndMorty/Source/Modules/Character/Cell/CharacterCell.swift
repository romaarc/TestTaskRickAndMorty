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
        layer.cornerRadius = CharacterConstants.Layout.cornerRadius
        layer.masksToBounds = true
        contentView.addSubview(characterImageView)
        setupUI()
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

