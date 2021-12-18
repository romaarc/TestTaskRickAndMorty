//
//  LocationInfoDetailView.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 13.12.2021.
//

import UIKit

class LocationInfoDetailView: BaseView {

    private let upLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
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
        label.textColor = .gray
        label.textColor = .black
        label.font = Font.sber(ofSize: Font.Size.twentyEight, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.02
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: 0.34, .paragraphStyle: paragraphStyle])
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let downLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.textColor = Colors.grayTabBar
        label.font = Font.sber(ofSize: Font.Size.thirteen, weight: .bold)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.16
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: -0.08, .paragraphStyle: paragraphStyle])
        label.textAlignment = .center
        return label
    }()
    
    
    override func setupView() {
        backgroundColor = Colors.grayDetail
        [upLabel, nameLabel, downLabel].forEach { addSubview($0) }
    }

    override func setupLayout() {
        NSLayoutConstraint.activate([
            upLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            upLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            upLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            upLabel.heightAnchor.constraint(equalToConstant: 13),
            
            nameLabel.topAnchor.constraint(equalTo: upLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            nameLabel.heightAnchor.constraint(equalToConstant: 34),
            
            downLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            downLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            downLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            downLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}
//MARK: - UI
extension LocationInfoDetailView {
    //MARK: - Update with ViewModel
    func update(with viewModel: LocationViewModel) {
        upLabel.text = viewModel.type
        nameLabel.text = viewModel.name
        downLabel.text = viewModel.dimension.uppercased()
    }
    
    func update(with viewModel: EpisodeViewModel) {
        upLabel.text = viewModel.airDate
        nameLabel.text = viewModel.name
        downLabel.text = viewModel.episode
    }
}
