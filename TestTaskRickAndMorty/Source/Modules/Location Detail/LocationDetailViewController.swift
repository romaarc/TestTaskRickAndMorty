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
    private let charactersviewModels: [CharacterViewModel] = []
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var locationInfoDetailView = LocationInfoDetailView()

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
	}
    
    override func setupUI() {
        super.setupUI()
        navigationItem.largeTitleDisplayMode = .never
        title = locationViewModel.name
    }
    
    override func setupCollectionView() {
        setupHeaderView()
//        setupScrollView()
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.backgroundColor = .white
//        collectionView.register(LocationHeaderDetailView.self)
//        collectionView.register(UICollectionViewCell.self)
//        collectionView.addSubview(activityIndicator)
//        contentView.addSubview(collectionView)
//
//        NSLayoutConstraint.activate([
//            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            collectionView.topAnchor.constraint(equalTo: locationInfoDetailView.bottomAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//
//            activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor)
//        ])
    }
}

extension LocationDetailViewController: LocationDetailViewInput {
}

private extension LocationDetailViewController {
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
        view.addSubview(locationInfoDetailView)
        locationInfoDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationInfoDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationInfoDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            locationInfoDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        locationInfoDetailView.update(with: locationViewModel)
    }
}

//MARK: - UICollectionViewDataSource
extension LocationDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //viewModels.count
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: UICollectionViewCell.self, for: indexPath)
        cell.backgroundColor = .gray
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 1
        cell.layer.borderColor = Colors.borderLightGray.cgColor
        //let viewModel = viewModels[indexPath.row]
        //cell.update(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueSectionHeaderCell(cellType: LocationHeaderDetailView.self, for: indexPath)
        header.update(some: LocationDetailConstants.Strings.headerInfo)
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
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
        return CGSize(width: width, height: 219)
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing: CGFloat = (LocationDetailConstants.Layout.itemsInRow * LocationDetailConstants.Layout.spacingLeft + (LocationDetailConstants.Layout.itemsInRow - 1) * LocationDetailConstants.Layout.spacingRight) + LocationDetailConstants.Layout.minimumInteritemSpacingForSectionAt - LocationDetailConstants.Layout.spacing
        let finalWidth = (width - totalSpacing) / LocationDetailConstants.Layout.itemsInRow
        return floor(finalWidth)
    }
}
