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
        view.backgroundColor = Colors.lightWhite
    }
}
// MARK: - EpisodeViewInput from Presenter
extension EpisodeViewController: EpisodeViewInput {
    func set(viewModels: [EpisodeViewModel], seasons: [Int: Int]) {
        self.viewModels = viewModels
        self.seasons = seasons
        DispatchQueue.main.async {
            self.tableView.restore()
            self.tableView.reloadData()
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
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
//        let episodeDetailsController = EpisodeDetailsController(episode: self.episodes[indexPath.row])
//        navigationController?.pushViewController(episodeDetailsController, animated: true)
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
