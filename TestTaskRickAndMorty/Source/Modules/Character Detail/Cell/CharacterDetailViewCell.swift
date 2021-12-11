//
//  CharacterDetailViewCell.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//

import UIKit

final class CharacterDetailViewCell: BaseUITableViewCell {
    
    private let characterImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override func setupView() {
        selectionStyle = .none
        contentView.addSubview(characterImageView)
        setupUI()
    }
}
//MARK: - UI
extension CharacterDetailViewCell {
    private func setupUI() {
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
//MARK: - Updating ViewModel
    func update(with viewModel: CharacterViewModel) {
        characterImageView.setImageOffline(with: URL(string: viewModel.imageURL))
    }
}
