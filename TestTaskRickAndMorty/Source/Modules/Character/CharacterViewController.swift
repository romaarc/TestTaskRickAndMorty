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
    private let searchController = UISearchController()
    private let collectionView: UICollectionView
    private var viewModels = [CharacterViewModel]()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        activity.color = UIColor.black
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
        view.addSubview(self.collectionView)
        self.setupCollectionView()
        self.view = view
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        setupUI()
        self.output.viewDidLoad()
        configureSearchController()
	}
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(activityIndicator)
        
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
        collectionView.register(CharacterCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    func startActivityIndicator() {
        activityIndicator.startAnimating()
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
        let width = (view.bounds.width - 3 * 10) / 3
        return CGSize(width: width, height: width + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      //showDetailVCFullscreen(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.output.willDisplay(at: indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}

//MARK: - CharacterViewInput from Presenter
extension CharacterViewController: CharacterViewInput {
    func set(viewModels: [CharacterViewModel]) {
        DispatchQueue.main.async {
            self.startActivityIndicator()
        }
        self.viewModels = viewModels
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.stopActivityIndicator()
        }
    }
}

//MARK: - Filter VC
private extension CharacterViewController {
    @objc func filterButtonClicked() {
    }
}

// MARK: - Search bar methods
extension CharacterViewController: UISearchBarDelegate {
    private func configureSearchController(){
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Localize.Images.characterFilterSymbol, style: .plain, target: self, action: #selector(filterButtonClicked))
        
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Найти героя"
        searchController.searchBar.searchTextField.font = Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        searchController.obscuresBackgroundDuringPresentation = false
        
        let attributes:[NSAttributedString.Key: Any] = [
            .font: Font.sber(ofSize: Font.Size.seventeen, weight: .regular)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Отмена"
    }

    private func setSearchController() {

    }
    
    private func getCharactersBySearchQuery(searchQuery: String) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
}
