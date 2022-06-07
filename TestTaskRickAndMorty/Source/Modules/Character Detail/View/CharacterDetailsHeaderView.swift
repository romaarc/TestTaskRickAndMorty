//
//  CharacterDetailsHeaderView.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 12.12.2021.
//

import UIKit

final class CharacterDetailsHeaderView: UIView {

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = Colors.grayDetail
        return imageView
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.borderColor = Colors.grayDetail.cgColor
        imageView.layer.borderWidth = 5.0
        imageView.layer.cornerRadius = 70.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        label.font = Font.sber(ofSize: Font.Size.eleven, weight: .regular)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: 0.07, .paragraphStyle: paragraphStyle])
        label.textAlignment = .center
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = Font.sber(ofSize: Font.Size.twentyEight, weight: .bold)

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.02
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: 0.34, .paragraphStyle: paragraphStyle])
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.grayTabBar
        label.font = Font.sber(ofSize: Font.Size.thirteen, weight: .regular)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: -0.08, .paragraphStyle: paragraphStyle])
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.grayDetail
        setupView()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        [backgroundImageView, avatarImageView, statusLabel, nameLabel, speciesLabel].forEach { addSubview($0) }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 19.0),
            avatarImageView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: -70.0),
            avatarImageView.heightAnchor.constraint(equalToConstant: 140.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 140.0),
            
            statusLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 15.0),
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            speciesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            speciesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            speciesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func update(viewModel: CharacterViewModel) {
        statusLabel.text = viewModel.status
        nameLabel.text = viewModel.name
        speciesLabel.text = viewModel.species.uppercased()
        avatarImageView.setImageOffline(with: URL(string: viewModel.imageURL))
    }
}
