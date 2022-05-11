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
    private var tableView = UITableView(frame: .zero, style: .grouped)
    private var viewModels: [EpisodeViewModel] = []
    private var seasons: [Int: Int] = [:]
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.hidesWhenStopped = true
        activity.color = .black
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

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
        output.viewDidLoad()
	}
    
    private func setupUI() {
        view.backgroundColor = .white
    }
}
// MARK: - EpisodeViewInput from Presenter
extension EpisodeViewController: EpisodeViewInput {
    func set(viewModels: [EpisodeViewModel], seasons: [Int: Int]) {
        self.viewModels = viewModels
        self.seasons = seasons
        DispatchQueue.main.async {
            if self.viewModels.isEmpty {
                self.tableView.setEmptyMessage(message: EpisodeConstants.Strings.emptyMessage)
            } else {
                self.tableView.restore()
                self.tableView.reloadData()
            }
        }
    }
    
    func didError() {
        DispatchQueue.main.async {
            if self.viewModels.isEmpty {
                self.tableView.performBatchUpdates {
                    var indexPaths: [IndexPath] = []
                    for s in 0..<self.tableView.numberOfSections {
                        for i in 0..<self.tableView.numberOfRows(inSection: s) {
                            indexPaths.append(IndexPath(row: i, section: s))
                        }
                    }
                    self.tableView.deleteRows(at: indexPaths, with: .automatic)
                } completion: {_ in
                    self.tableView.setEmptyMessage(message: EpisodeConstants.Strings.emptyMessage)
                }
            }
        }
    }
}

private extension EpisodeViewController {
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EpisodeCell.self)
        tableView.register(EpisodeHeaderSectionView.self)
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .zero
        }
        tableView.sectionFooterHeight = .zero
        
        tableView.addSubview(activityIndicator)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
// MARK: - UITableViewDelegate
extension EpisodeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueHeaderFooterViewCell(cellType: EpisodeHeaderSectionView.self)
        header.update(with: Array(seasons.keys).sorted(), section: section)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 54.5
        default:
            return 74.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let generator = UISelectionFeedbackGenerator()
        let seasonsKeys = Array(seasons.keys).sorted()
        let seasonEpisodes = viewModels.filter({ $0.episode.contains("S0" + String(seasonsKeys[indexPath.section] + 1)) })
        let viewModel = seasonEpisodes[indexPath.row]
        generator.prepare()
        generator.selectionChanged()
        output.onRowTap(with: viewModel)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        output.willDisplay(at: indexPath.item, on: indexPath.section)
    }
}
// MARK: - UITableViewDataSource
extension EpisodeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return seasons.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countSeasons = seasons[section] else { return 0 }
        return countSeasons
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: EpisodeCell.self, for: indexPath)
        let seasonsKeys = Array(seasons.keys).sorted()
        let seasonEpisodes = viewModels.filter({ $0.episode.contains("S0" + String(seasonsKeys[indexPath.section] + 1)) })
        cell.selectionStyle = .none
        cell.update(with: seasonEpisodes, indexPath: indexPath)
        return cell
    }
}
//MARK: - activityIndicator
extension EpisodeViewController {
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
}
