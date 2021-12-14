//
//  CharacterFilterViewController.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 09.12.2021.
//

import UIKit

protocol CharacterFilterDelegate: AnyObject {
    func didFilterTapped(status: String, gender: String)
    func didClearTapped()
}

class CharacterFilterViewController: UIViewController {
    
    weak var delegate: CharacterFilterDelegate?
    private let statusCharacters = ["Alive", "Dead", "Unknown"]
    private let genderCharacters = ["Female", "Male", "Genderless", "Unknown"]
    private lazy var tableView = UITableView(frame: .zero, style: .grouped)
  
    private let navBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let rowView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.grayDetail
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let filterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.sber(ofSize: Font.Size.seventeen, weight: .bold)
        label.text = "Filter"
        return label
    }()
    
    private let applyButton: UIButton = {
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.filled()
            configuration.title = "APPLY"
            configuration.attributedTitle?.kern = -0.08
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.16
            configuration.attributedTitle?.paragraphStyle = paragraphStyle
            configuration.attributedTitle?.font = Font.sber(ofSize: Font.Size.thirteen, weight: .bold)
            configuration.baseForegroundColor = .white
            configuration.baseBackgroundColor = Colors.purple
            configuration.cornerStyle = .capsule
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 12, bottom: 5, trailing: 12)
            let button = UIButton(configuration: configuration, primaryAction: nil)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        } else {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 14
            button.layer.masksToBounds = true
            button.frame.size = CGSize(width: 66, height: 28)
            
            let title = NSMutableAttributedString()
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.16
            paragraphStyle.alignment = .center
            let part = NSAttributedString(string: "APPLY         ",
                                          attributes: [.foregroundColor: UIColor.white,
                                                       .font: Font.sber(ofSize: Font.Size.thirteen, weight: .bold),
                                                       .paragraphStyle: paragraphStyle,
                                                       .kern: -0.08])
            title.append(part)
            button.titleEdgeInsets = UIEdgeInsets(top: 3, left: 12, bottom: 5, right: 12)
            button.setAttributedTitle(title, for: .normal)
            button.backgroundColor = Colors.purple
            return button
        }
    }()
    
    private let clearButton: UIButton = {
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.title = "Clear"
            configuration.attributedTitle?.kern = -0.41
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.08
            configuration.attributedTitle?.paragraphStyle = paragraphStyle
            configuration.attributedTitle?.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
            configuration.baseForegroundColor = Colors.purple
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            let button = UIButton(configuration: configuration, primaryAction: nil)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        } else {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.frame.size = CGSize(width: 44, height: 22)
            let title = NSMutableAttributedString()
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.08
            paragraphStyle.alignment = .center
            let part = NSAttributedString(string: "Clear",
                                          attributes: [.foregroundColor: Colors.purple,
                                                       .font: Font.sber(ofSize: Font.Size.seventeen, weight: .regular),
                                                       .paragraphStyle: paragraphStyle,
                                                       .kern: -0.41])
            title.append(part)
            button.setAttributedTitle(title, for: .normal)
            return button
        }
    }()
    
    private func setupNavBar() {
        
        view.layer.cornerRadius = 10
        
        [rowView, navBarView].forEach { view.addSubview($0) }
        [clearButton, filterLabel, applyButton].forEach { navBarView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            rowView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            rowView.widthAnchor.constraint(equalTo: filterLabel.widthAnchor),
            rowView.heightAnchor.constraint(equalToConstant: 5),
            rowView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            navBarView.topAnchor.constraint(equalTo: rowView.bottomAnchor, constant: 0),
            navBarView.heightAnchor.constraint(equalToConstant: 44),
            navBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            clearButton.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor, constant: 16),
            clearButton.topAnchor.constraint(equalTo: navBarView.topAnchor, constant: 11),
            clearButton.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: -13),
            clearButton.widthAnchor.constraint(equalToConstant: 41),
            
            filterLabel.centerXAnchor.constraint(equalTo: navBarView.centerXAnchor),
            filterLabel.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor),
            
            applyButton.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor, constant: -15),
            applyButton.topAnchor.constraint(equalTo: navBarView.topAnchor, constant: 8)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
    }
    
    init(currentStatus: String, currentGender: String) {
        super.init(nibName: nil, bundle: nil)
//        if currentStatus != "" {
//            self.statusTextField.text = currentStatus
//        }
//        if currentGender != "" {
//            self.genderTextField.text = currentGender
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
