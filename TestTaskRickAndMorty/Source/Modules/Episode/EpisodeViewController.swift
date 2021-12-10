//
//  EpisodeViewController.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import UIKit

final class EpisodeViewController: UIViewController {
	private let output: EpisodeViewOutput
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var dataSource: UITableViewDiffableDataSource<Section, Episode>!
    private var viewModels: [EpisodeViewModel] = []

    init(output: EpisodeViewOutput) {
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
extension EpisodeViewController: EpisodeViewInput {
    func set(viewModels: [EpisodeViewModel], episodes: [Episode]) {
        self.viewModels = viewModels
        DispatchQueue.main.async {
            self.tableView.restore()
            self.createSnapshot(from: episodes)
        }
    }
    
    func didError() {
        DispatchQueue.main.async {
            if self.viewModels.isEmpty {
                guard let indexPathsForVisibleRows = self.tableView.indexPathsForVisibleRows else { return }
                self.tableView.deleteRows(at: indexPathsForVisibleRows, with: .automatic)
                self.tableView.setEmptyMessage(message: "Не найдено эпизодов")
            }
        }
    }
}
// MARK: - TableView DataSource
extension EpisodeViewController: UITableViewDelegate {
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
        dataSource = UITableViewDiffableDataSource<Section, Episode>(tableView: tableView) {(tableView, indexPath, locationModel) -> UITableViewCell? in
            let cell = UITableViewCell()
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.text = locationModel.name
            cell.textLabel?.font = Font.sber(ofSize: Font.Size.twenty, weight: .regular)
            return cell
        }
    }
    
    private func createSnapshot(from addedEpisodes: [Episode]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Episode>()
        snapshot.appendSections([.main])
        snapshot.appendItems(addedEpisodes)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        output.willDisplay(at: indexPath.item)
    }
}
