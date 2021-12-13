//
//  CharacterDetailViewCell.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//

import UIKit

final class CharacterDetailViewCell: BaseUITableViewCell {
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = Font.sber(ofSize: Font.Size.seventeen, weight: .bold)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: -0.41, .paragraphStyle: paragraphStyle])
        return label
    }()
    
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        label.font = Font.sber(ofSize: Font.Size.fithteen, weight: .regular)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: -0.24, .paragraphStyle: paragraphStyle])
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "arrow")
        return imageView
    }()
    
    override func setupView() {
        [label, subLabel, arrowImageView].forEach { contentView.addSubview($0) }
        setupUI()
    }
}
//MARK: - UI
extension CharacterDetailViewCell {
    private func setupUI() {
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.5),
            self.label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            self.subLabel.topAnchor.constraint(equalTo: label.bottomAnchor),
            self.subLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            self.subLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.5),
            
            self.arrowImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 23.0),
            self.arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18.0),
            self.arrowImageView.heightAnchor.constraint(equalToConstant: 22.0),
            self.arrowImageView.widthAnchor.constraint(equalToConstant: 13.0)
        ])
    }
//MARK: - Updating ViewModel
    func update(with viewModel: CharacterViewModel, indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            label.text = "Gender"
            subLabel.text = viewModel.gender
            arrowImageView.isHidden = true
            isUserInteractionEnabled = false
        case 1:
            label.text = "Origin"
            subLabel.text = viewModel.origin.name
            arrowImageView.isHidden = true
            isUserInteractionEnabled = false
        case 2:
            label.text = "Type"
            subLabel.text = viewModel.type == "" ? "unspecified" : viewModel.type
            arrowImageView.isHidden = true
            isUserInteractionEnabled = false
        case 3:
            label.text = "Location"
            subLabel.text = viewModel.location.name
            arrowImageView.isHidden = false
            isUserInteractionEnabled = true
        default:
            break
        }
    }
}
