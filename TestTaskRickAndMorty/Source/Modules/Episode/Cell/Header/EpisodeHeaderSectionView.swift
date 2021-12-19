//
//  EpisodeHeaderSectionView.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 11.12.2021.
//

import UIKit

class EpisodeHeaderSectionView: BaseUITableViewHeaderFooterView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.grayTabBar
        label.font = Font.sber(ofSize: Font.Size.twenty, weight: .bold)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: 0.38, .paragraphStyle: paragraphStyle])
        return label
    }()
    
    override func setupView() {
        contentView.addSubview(label)
        setupUI()
    }
}
    //MARK: - UI
extension EpisodeHeaderSectionView {
    private func setupUI() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9.5)
        ])
    }
    //MARK: - Update
    func update(with viewModel: [Int], section: Int) {
        label.text = "\(EpisodeConstants.Strings.seasonTitle) \(String(viewModel[section] + 1))"
    }
    
    func update(someText text: String) {
        label.text = text
    }
}
