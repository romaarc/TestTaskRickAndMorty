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
    private let characterViewModel: CharacterViewModel
    private var episodeViewModels: [EpisodeViewModel] = []
    private var locationViewModel: LocationViewModel?
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var tableView = UITableView(frame: .zero, style: .grouped)
    private lazy var characterDetailsHeaderView = CharacterDetailsHeaderView()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.hidesWhenStopped = true
        activity.color = .black
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

    init(output: CharacterDetailViewOutput, viewModel: CharacterViewModel) {
        self.output = output
        self.characterViewModel = viewModel
        self.locationViewModel = nil
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
		super.viewDidLoad()
        setupNavBar()
        setupTableView()
        output.viewDidLoad(with: characterViewModel.episodes,
                           and: characterViewModel.location.url)
	}
    
    private func setupNavBar() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        title = characterViewModel.name
    }
}

extension CharacterDetailViewController: CharacterDetailViewInput {
    func set(viewModels: [EpisodeViewModel], and location: LocationViewModel?) {
        self.episodeViewModels = viewModels
        self.locationViewModel = location
        DispatchQueue.main.async {
            self.tableView.restore()
            self.tableView.reloadData()
        }
    }
    
    func didError() {
        DispatchQueue.main.async {
            if self.episodeViewModels.isEmpty {
                self.tableView.performBatchUpdates {
                    var indexPaths: [IndexPath] = []
                    for s in 0..<self.tableView.numberOfSections {
                        for i in 0..<self.tableView.numberOfRows(inSection: s) {
                            indexPaths.append(IndexPath(row: i, section: s))
                        }
                    }
                    self.tableView.deleteRows(at: indexPaths, with: .automatic)
                } completion: {_ in
                    self.tableView.setEmptyMessage(message: "Не найдено эпизодов или локаций")
                }
            }
        }
    }
}
//MARK: - TableView
private extension CharacterDetailViewController {
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let contentViewHeightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        contentViewHeightAnchor.priority = .defaultLow
        contentViewHeightAnchor.isActive = true
        
        contentView.backgroundColor = .white
    }
    
    private func setupHeaderView() {
        contentView.addSubview(characterDetailsHeaderView)
        NSLayoutConstraint.activate([
            characterDetailsHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterDetailsHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterDetailsHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        characterDetailsHeaderView.update(viewModel: characterViewModel)
    }
    
    func setupTableView() {
        setupScrollView()
        setupHeaderView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.isUserInteractionEnabled = true
        tableView.backgroundColor = .white
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .zero
        }
        tableView.sectionFooterHeight = .zero
        
        tableView.register(CharacterDetailViewCell.self)
        tableView.register(EpisodeCell.self)
        tableView.register(EpisodeHeaderSectionView.self)

        contentView.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: characterDetailsHeaderView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
//MARK: - UITableViewDataSource
extension CharacterDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        CharacterDetailConstants.Layout.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return CharacterDetailConstants.Layout.cellCount
        case 1:
            return episodeViewModels.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueCell(cellType: CharacterDetailViewCell.self, for: indexPath)
            cell.update(with: characterViewModel, indexPath: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueCell(cellType: EpisodeCell.self, for: indexPath)
            cell.update(with: episodeViewModels[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let generator = UISelectionFeedbackGenerator()
        if indexPath.section == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            guard let location = locationViewModel else { return }
            generator.selectionChanged()
            output.showLocation(with: location)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            let viewModel = episodeViewModels[indexPath.row]
            generator.selectionChanged()
            output.showEpisode(with: viewModel)
        }
    }
}
//MARK: - UITableViewDelegate
extension CharacterDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueHeaderFooterViewCell(cellType: EpisodeHeaderSectionView.self)
        switch section {
        case 0:
            header.update(someText: CharacterDetailConstants.Strings.headerInfo)
        case 1:
            header.update(someText: CharacterDetailConstants.Strings.headerEpi)
        default:
            return nil
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 54.5
        case 1:
            return 74.0
        default:
            return 0.0
        }
    }
    
    ///Animate hide headerView maybe will be in future
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            UIView.animate(withDuration: 1 / 3, delay: 0, options: .curveEaseIn) {
                self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -254).isActive = true
                self.tableView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -79).isActive = true
                self.view.layoutIfNeeded()
            }
        }
    }
}
//MARK: - activityIndicator
extension CharacterDetailViewController {
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
}
