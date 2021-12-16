//
//  FilterCell.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 14.12.2021.
//

import UIKit

class FilterCell: BaseUITableViewCell {
    
    private let radioImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: -0.41, .paragraphStyle: paragraphStyle])
        return label
    }()
    
    private let checkedImage = UIImage(named: "checked")
    private let uncheckedImage = UIImage(named: "unchecked")
    
    func isSelected(_ selected: Bool) {
        setSelected(selected, animated: false)
        let image = selected ? checkedImage : uncheckedImage
        self.radioImageView.image = image
    }
    
    override func setupView() {
        [radioImageView, label].forEach { contentView.addSubview($0) }
        setupUI()
    }
}
//MARK: - UI
extension FilterCell {
    private func setupUI() {
        NSLayoutConstraint.activate([
            radioImageView.topAnchor.constraint(equalTo: topAnchor, constant: 9.5),
            radioImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            radioImageView.heightAnchor.constraint(equalToConstant: 30.0),
            radioImageView.widthAnchor.constraint(equalToConstant: 28.0),
            
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10.5),
            label.leadingAnchor.constraint(equalTo: radioImageView.trailingAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.5),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    //MARK: - Update with text
    func update(some text: String) {
        label.text = text
    }
}
