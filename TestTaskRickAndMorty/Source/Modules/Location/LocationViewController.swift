//
//  LocationViewController.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import UIKit

final class LocationViewController: UIViewController {
	private let output: LocationViewOutput
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var dataSource: UITableViewDiffableDataSource<Section, Location>!
    private var viewModels: [LocationViewModel] = []
    
    init(output: LocationViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
		super.viewDidLoad()
        setupUI()
        setupTableView()
        setupDataSource()
        output.viewDidLoad()
	}
    
    private func setupUI() {
        view.backgroundColor = Colors.lightWhite
    }
}

// MARK: - LocationViewInput from Presenter
extension LocationViewController: LocationViewInput {
    func set(viewModels: [LocationViewModel], locations: [Location]) {
        self.viewModels = viewModels
        DispatchQueue.main.async {
            self.tableView.restore()
            self.createSnapshot(from: locations)
        }
    }
    
    func didError() {
        DispatchQueue.main.async {
            if self.viewModels.isEmpty {
                guard let indexPathsForVisibleRows = self.tableView.indexPathsForVisibleRows else { return }
                self.tableView.deleteRows(at: indexPathsForVisibleRows, with: .automatic)
                self.tableView.setEmptyMessage(message: "Не найдено локаций")
            }
        }
    }
}

// MARK: - TableView DataSource
extension LocationViewController: UITableViewDelegate {
    private func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Colors.Gradient.topColor
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.contentInset = UIEdgeInsets(top: 10, left: .zero, bottom: .zero, right: .zero)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupDataSource(){
        dataSource = UITableViewDiffableDataSource<Section, Location>(tableView: tableView) {(tableView, indexPath, locationModel) -> UITableViewCell? in
            let cell = UITableViewCell()
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.text = locationModel.name
            cell.textLabel?.font = Font.sber(ofSize: Font.Size.twenty, weight: .regular)
            return cell
        }
    }
    
    private func createSnapshot(from addedLocations: [Location]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Location>()
        snapshot.appendSections([.main])
        snapshot.appendItems(addedLocations)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        output.willDisplay(at: indexPath.item)
    }
}
