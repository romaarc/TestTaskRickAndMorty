//
//  CharacterFilterViewController.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 09.12.2021.
//

import UIKit

protocol CharacterFilterDelegate: AnyObject {
    func didFilterTapped(with filter: Filter)
    func didClearTapped()
}

class CharacterFilterViewController: UIViewController {
    
    weak var delegate: CharacterFilterDelegate?
    var filter = Filter(statusIndexPath: nil,
                        genderIndexPath: nil)
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
        
        applyButton.addTarget(self, action: #selector(apply), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clear), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupTableView()
    }
    
    init(filter: Filter) {
        super.init(nibName: nil, bundle: nil)
        self.filter = filter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 56, bottom: 0, right: 0)
        tableView.contentInsetAdjustmentBehavior = .never
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.sectionFooterHeight = 0
        tableView.register(FilterCell.self)
        tableView.register(FilterHeader.self)

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: navBarView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func apply() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        delegate?.didFilterTapped(with: filter)
        dismiss(animated: true)
    }
    
    @objc private func clear() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        delegate?.didClearTapped()
        dismiss(animated: true)
    }
}
//MARK: - UITableViewDelegate
extension CharacterFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let cell = tableView.dequeueHeaderFooterViewCell(cellType: FilterHeader.self)
            cell.update(someText: "Status")
            return cell
        case 1:
            let cell = tableView.dequeueHeaderFooterViewCell(cellType: FilterHeader.self)
            cell.update(someText: "Gender")
            return cell
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 46.0
        case 1:
            return 56.0
        default:
            return 0.0
        }
    }
}
//MARK: - UITableViewDataSource
extension CharacterFilterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return filter.statusCharacters.count
        case 1:
            return filter.genderCharacters.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: FilterCell.self, for: indexPath)
        switch indexPath.section {
        case 0:
            cell.update(some: filter.statusCharacters[indexPath.row])
            cell.selectionStyle = .none
            cell.isSelected(filter.statusIndexPath == indexPath)
            return cell
        case 1:
            cell.update(some: filter.genderCharacters[indexPath.row])
            cell.selectionStyle = .none
            cell.isSelected(filter.genderIndexPath == indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            filter.statusIndexPath = indexPath
        case 1:
            filter.genderIndexPath = indexPath
        default:
            break
        }
        tableView.reloadData()
    }
}
