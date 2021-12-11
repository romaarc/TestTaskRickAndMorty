//
//  CharacterDetailDescriptionCell.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//

import UIKit

final class CharacterDetailDescriptionCell: BaseUITableViewCell {
    
    private let characterImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.sber(ofSize: Font.Size.twentyEight, weight: .bold)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.font = Font.sber(ofSize: Font.Size.twenty, weight: .regular)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = Font.sber(ofSize: Font.Size.twenty, weight: .regular)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 4
        return stack
    }()
    
    override func setupView() {
        selectionStyle = .none
        contentView.addSubview(labelsStackView)
        setupUI()
    }
}
//MARK: - UI
extension CharacterDetailDescriptionCell {
    private func setupUI() {
        [nameLabel, genderLabel, speciesLabel].forEach { labelsStackView.addArrangedSubview($0) }
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            labelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
    }
//MARK: - Updating ViewModel
    func update(with viewModel: CharacterViewModel) {
        nameLabel.text = "Name: \(viewModel.name)"
        genderLabel.text = "Gender: \(viewModel.gender)"
        speciesLabel.text = "Species: \(viewModel.species)"
    }
}
