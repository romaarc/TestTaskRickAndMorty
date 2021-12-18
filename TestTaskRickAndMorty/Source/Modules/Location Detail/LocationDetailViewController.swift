//
//  LocationDetailViewController.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 12.12.2021.
//  
//

import UIKit

final class LocationDetailViewController: BaseViewController {
	private let output: LocationDetailViewOutput
    private let locationViewModel: LocationViewModel
    private var charactersViewModels: [CharacterViewModel] = []
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var infoDetailView = LocationInfoDetailView()
    private var startLayout: NSLayoutConstraint!

    init(output: LocationDetailViewOutput, viewModel: LocationViewModel) {
        self.output = output
        self.locationViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        output.viewDidLoad(with: locationViewModel.residents)
	}
    
    override func setupUI() {
        super.setupUI()
        navigationItem.largeTitleDisplayMode = .never
        title = locationViewModel.name
    }
    
    override func setupCollectionView() {
        setupScrollView()
        setupHeaderView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(LocationHeaderDetailView.self)
        collectionView.register(LocationDetailCell.self)
        collectionView.addSubview(activityIndicator)
        
        contentView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: infoDetailView.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor)
        ])
    }
}

extension LocationDetailViewController: LocationDetailViewInput {
    func set(viewModels: [CharacterViewModel]) {
        self.charactersViewModels = viewModels
        DispatchQueue.main.async {
            self.collectionView.restore()
            self.collectionView.reloadData()
        }
    }
    
    func didError() {
        DispatchQueue.main.async {
            if self.charactersViewModels.isEmpty {
                self.collectionView.performBatchUpdates {
                    var indexPaths: [IndexPath] = []
                    for s in 0..<self.collectionView.numberOfSections {
                        for i in 0..<self.collectionView.numberOfItems(inSection: s) {
                            indexPaths.append(IndexPath(row: i, section: s))
                        }
                    }
                    self.collectionView.deleteItems(at: indexPaths)
                } completion: {_ in
                    self.collectionView.setEmptyMessage(message: "Не найдено резидентов")
                }
            }
        }
    }
}

private extension LocationDetailViewController {
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        startLayout = scrollView.topAnchor.constraint(equalTo: view.topAnchor)
        
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
    
    func setupHeaderView() {
        contentView.addSubview(infoDetailView)
        infoDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoDetailView.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoDetailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoDetailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            infoDetailView.heightAnchor.constraint(equalToConstant: 139)
        ])
        infoDetailView.update(with: locationViewModel)
    }
}
//MARK: - UICollectionViewDataSource
extension LocationDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        charactersViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: LocationDetailCell.self, for: indexPath)
        let viewModel = charactersViewModels[indexPath.row]
        cell.update(with: viewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueSectionHeaderCell(cellType: LocationHeaderDetailView.self, for: indexPath)
        header.update(some: LocationDetailConstants.Strings.headerInfo)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if charactersViewModels.isEmpty { return .zero }
        return CGSize(width: 298, height: 25)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        LocationDetailConstants.Layout.spacingBottom
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        LocationDetailConstants.Layout.minimumInteritemSpacingForSectionAt
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: LocationDetailConstants.Layout.spacingTop, left: LocationDetailConstants.Layout.spacingLeft, bottom: LocationDetailConstants.Layout.spacingBottom, right: LocationDetailConstants.Layout.spacingRight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: view.bounds.width, spacing: 10)
        return CGSize(width: width, height: width + LocationDetailConstants.Layout.heightCardDescription)
    }

    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing: CGFloat = (LocationDetailConstants.Layout.itemsInRow * LocationDetailConstants.Layout.spacingLeft + (LocationDetailConstants.Layout.itemsInRow - 1) * LocationDetailConstants.Layout.spacingRight) + LocationDetailConstants.Layout.minimumInteritemSpacingForSectionAt - LocationDetailConstants.Layout.spacing
        let finalWidth = (width - totalSpacing) / LocationDetailConstants.Layout.itemsInRow
        return floor(finalWidth)
    }

    //Animate hide headerView maybe will be in future
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            UIView.animate(withDuration: 1 / 3, delay: 0, options: .curveEaseIn) {
                self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -139).isActive = true
                self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -79).isActive = true
                self.view.layoutIfNeeded()
            }
        }
    }
}
