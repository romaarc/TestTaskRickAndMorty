//
//  CharacterViewController.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//  
//

import UIKit

final class CharacterViewController: BaseViewController {
    private let output: CharacterViewOutput
    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModels: [CharacterViewModel] = []
    private var filter = Filter(statusIndexPath: nil, genderIndexPath: nil)
    private var isOffline: Bool = false
    
    init(output: CharacterViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        super.setupUI()
        output.viewDidLoad()
        setupSearchController()
	}
        
    override func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(CharacterCell.self)
        collectionView.addSubview(activityIndicator)
        view.addSubview(collectionView)
        
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
//MARK: - UICollectionViewDataSource
extension CharacterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: CharacterCell.self, for: indexPath)
        let viewModel = viewModels[indexPath.row]
        cell.update(with: viewModel, isOffline: self.isOffline)
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
        animateOnTapCell(to: collectionView.cellForItem(at: indexPath))
        let generator = UISelectionFeedbackGenerator()
        let viewModel = viewModels[indexPath.row]
        generator.selectionChanged()
        output.onCellTap(with: viewModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        output.willDisplay(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: CharacterConstants.Layout.spacingTop, left: CharacterConstants.Layout.spacingLeft, bottom: CharacterConstants.Layout.spacingBottom, right: CharacterConstants.Layout.spacingRight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        CharacterConstants.Layout.spacingBottom
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        CharacterConstants.Layout.minimumInteritemSpacingForSectionAt
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
                    self.collectionView.setEmptyMessage(message: CharacterConstants.Strings.emptyMessageDidError)
                }
            }
        }
    }
    
    func set(viewModels: [CharacterViewModel], isOffline: Bool) {
        self.viewModels = viewModels
        self.isOffline = isOffline
        DispatchQueue.main.async {
            if self.viewModels.isEmpty {
                self.collectionView.setEmptyMessage(message: CharacterConstants.Strings.emptyMessage)
            } else {
                self.collectionView.restore()
                self.collectionView.reloadData()
            }
        }
    }
}
//MARK: - Filter VC
private extension CharacterViewController {
    @objc func filterButtonClicked() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        output.onFilterButtonTap(with: filter)
    }
}
// MARK: - Filter Delegate
extension CharacterViewController: CharacterFilterDelegate {
    func didFilterTapped(with filter: Filter) {
        if filter.statusIndexPath != nil || filter.genderIndexPath != nil {
            output.didFilterTapped(with: filter)
            self.filter = filter
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: Localize.Images.statusSymbol?.withTintColor(Colors.purple).withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)), style:  .plain, target: self, action: #selector(filterButtonClicked))
        }
    }
    
    func didClearTapped() {
        filter.statusIndexPath = nil
        filter.genderIndexPath = nil
        output.didFilterTapped(with: filter)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Localize.Images.characterFilterSymbol, style:  .plain, target: self, action: #selector(filterButtonClicked))
    }
}
// MARK: - Search bar methods
extension CharacterViewController: UISearchBarDelegate, UISearchResultsUpdating {
    private func setupSearchController() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Localize.Images.characterFilterSymbol, style:  .plain, target: self, action: #selector(filterButtonClicked))
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = CharacterConstants.Strings.searchBarPlaceholder
        searchController.searchBar.searchTextField.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        searchController.obscuresBackgroundDuringPresentation = false
        
        let attributes:[NSAttributedString.Key: Any] = [
            .font: Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = CharacterConstants.Strings.UISearchBarTitle
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if !text.isEmpty {
            viewModels.removeAll()
            output.searchBarTextDidEndEditing(with: text, and: filter)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let _ = filter.statusIndexPath, let _ = filter.genderIndexPath {
            viewModels.removeAll()
            output.searchBarTextDidEndEditing(with: "", and: filter)
        } else {
            viewModels.removeAll()
            output.searchBarCancelButtonClicked()
        }
    }
}
