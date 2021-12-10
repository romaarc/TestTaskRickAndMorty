//
//  CharacterDetailViewController.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import UIKit

final class CharacterDetailViewController: UIViewController {
	private let output: CharacterDetailViewOutput
    private let viewModel: CharacterViewModel
    private let tableView = UITableView(frame: .zero, style: .plain)

    init(output: CharacterDetailViewOutput, viewModel: CharacterViewModel) {
        self.output = output
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = Colors.lightWhite
        setupNavBar()
        setupTableView()
	}
    
    private func setupNavBar() {
        navigationItem.largeTitleDisplayMode = .never
        title = viewModel.name
    }
}

extension CharacterDetailViewController: CharacterDetailViewInput {}

//MARK: - TableView
private extension CharacterDetailViewController {
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = Colors.lightWhite
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(CharacterDetailViewCell.self)
        tableView.register(CharacterDetailDescriptionCell.self)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CharacterDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return CharacterDetailConstants.Layout.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CharacterDetailConstants.Layout.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == .zero {
            let headerCell = tableView.dequeueCell(cellType: CharacterDetailViewCell.self, for: indexPath)
            headerCell.update(with: viewModel)
            return headerCell
        } else {
            let descriptionCell = tableView.dequeueCell(cellType: CharacterDetailDescriptionCell.self, for: indexPath)
            descriptionCell.update(with: viewModel)
            return descriptionCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == .zero {
            return CharacterDetailConstants.Layout.tableDetailCellHeight
        }
        return CharacterDetailConstants.Layout.tableDescriptionCellHeight
    }
}
