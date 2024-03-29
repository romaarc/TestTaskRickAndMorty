//
//  EpisodeCell.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 11.12.2021.
//

import UIKit

final class EpisodeCell: BaseUITableViewCell {
    
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
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.grayTabBar
        label.font = Font.sber(ofSize: Font.Size.eleven, weight: .bold)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: 0.07, .paragraphStyle: paragraphStyle])
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
        [label, subLabel, dateLabel, arrowImageView].forEach { contentView.addSubview($0) }
        setupUI()
    }
}
//MARK: - UI
extension EpisodeCell {
    private func setupUI() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6.5),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            subLabel.topAnchor.constraint(equalTo: label.bottomAnchor),
            subLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            dateLabel.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 5.0),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11.5),
            
            arrowImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 31.0),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18.0),
            arrowImageView.heightAnchor.constraint(equalToConstant: 22.0),
            arrowImageView.widthAnchor.constraint(equalToConstant: 13.0)
        ])
    }
    //MARK: - Update with ViewModel
    func update(with viewModel: [EpisodeViewModel], indexPath: IndexPath) {
        label.text = viewModel[indexPath.row].episode
        subLabel.text = viewModel[indexPath.row].name
        dateLabel.text = viewModel[indexPath.row].airDate.uppercased()
    }
    
    func update(with viewModel: EpisodeViewModel) {
        label.text = viewModel.episode
        subLabel.text = viewModel.name
        dateLabel.text = viewModel.airDate.uppercased()
    }
}
