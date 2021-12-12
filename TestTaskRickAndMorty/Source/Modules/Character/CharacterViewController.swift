//
//  CharacterViewController.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//  
//

import UIKit

final class CharacterViewController: UIViewController {
    private let output: CharacterViewOutput
    private let searchController = UISearchController(searchResultsController: nil)
    private let collectionView: UICollectionView
    private var viewModels: [CharacterViewModel] = []
    private var status: String?
    private var gender: String?
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.hidesWhenStopped = true
        activity.color = .black
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

    init(output: CharacterViewOutput) {
        self.output = output
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        collectionView.addSubview(activityIndicator)
        view.addSubview(collectionView)
        setupCollectionView()
        self.view = view
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        setupUI()
        output.viewDidLoad()
        setupSearchController()
	}
    
    private func setupUI() {
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.frame
    }
    
}
//MARK: - Extensions CollectionsView
private extension CharacterViewController {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(CharacterCell.self)
    }
}
//MARK: - UICollectionViewDataSource
extension CharacterViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: CharacterCell.self, for: indexPath)
        let viewModel = viewModels[indexPath.row]
        cell.update(with: viewModel)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CharacterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: view.bounds.width, spacing: CharacterConstants.Layout.spacing)
        return CGSize(width: width, height: width + CharacterConstants.Layout.heightCardDescription)
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing: CGFloat = (CharacterConstants.Layout.itemsInRow * CharacterConstants.Layout.spacingLeft + (CharacterConstants.Layout.itemsInRow - 1) * CharacterConstants.Layout.spacingRight) + CharacterConstants.Layout.minimumInteritemSpacingForSectionAt - CharacterConstants.Layout.spacing
        let finalWidth = (width - totalSpacing) / CharacterConstants.Layout.itemsInRow
        return floor(finalWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        output.onCellTap(with: viewModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        output.willDisplay(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CharacterConstants.Layout.spacingTop, left: CharacterConstants.Layout.spacingLeft, bottom: CharacterConstants.Layout.spacingBottom, right: CharacterConstants.Layout.spacingRight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CharacterConstants.Layout.spacingBottom
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CharacterConstants.Layout.minimumInteritemSpacingForSectionAt
    }
}

//MARK: - CharacterViewInput from Presenter
extension CharacterViewController: CharacterViewInput {
    func didError() {
        DispatchQueue.main.async {
            if self.viewModels.isEmpty {
                self.collectionView.performBatchUpdates {
                    var indexPaths: [IndexPath] = []
                    for s in 0..<self.collectionView.numberOfSections {
                        for i in 0..<self.collectionView.numberOfItems(inSection: s) {
                            indexPaths.append(IndexPath(row: i, section: s))
                        }
                    }
                    self.collectionView.deleteItems(at: indexPaths)
                } completion: {_ in
                    self.collectionView.setEmptyMessage(message: "Не найдено персонажей")
                }
            }
        }
    }
    
    func set(viewModels: [CharacterViewModel], isSearch: Bool) {
        self.viewModels = viewModels
        DispatchQueue.main.async {
            if !self.viewModels.isEmpty {
                self.collectionView.restore()
                self.collectionView.reloadData()
            }
        }
    }
}

//MARK: - Filter VC
private extension CharacterViewController {
    @objc func filterButtonClicked() {
        output.onFilterButtonTap(withStatus: status ?? "", withGender: gender ?? "")
    }
}
// MARK: - Filter Delegate
extension CharacterViewController: CharacterFilterDelegate {
    func didFilterTapped(status: String, gender: String) {
        if !status.isEmpty || !gender.isEmpty {
            output.didFilterTapped(withStatus: status, withGender: gender)
            self.status = status
            self.gender = gender
        }
    }
    func didClearTapped() {
        self.status = ""
        self.gender = ""
        output.didFilterTapped(withStatus: status ?? "", withGender: gender ?? "")
    }
    
}
// MARK: - Search bar methods
extension CharacterViewController: UISearchBarDelegate, UISearchResultsUpdating {
    private func setupSearchController() {
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Localize.Images.characterFilterSymbol, style: .plain, target: self, action: #selector(filterButtonClicked))
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Найти персонажа"
        searchController.searchBar.searchTextField.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        searchController.obscuresBackgroundDuringPresentation = false
        
        let attributes:[NSAttributedString.Key: Any] = [
            .font: Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Отменить"
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if !text.isEmpty {
            viewModels.removeAll()
            output.searchBarTextDidEndEditing(with: text, withStatus: status ?? "", withGender: gender ?? "")
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let status = status, let gender = gender {
            if status.isEmpty, gender.isEmpty {
                viewModels.removeAll()
                output.searchBarCancelButtonClicked()
            } else {
                viewModels.removeAll()
                output.searchBarTextDidEndEditing(with: "", withStatus: status, withGender: gender)
            }
        } else {
            viewModels.removeAll()
            output.searchBarCancelButtonClicked()
        }
    }
}
//MARK: - activityIndicator
extension CharacterViewController {
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
}
