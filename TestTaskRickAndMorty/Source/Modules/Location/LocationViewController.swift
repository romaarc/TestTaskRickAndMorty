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
    private let collectionView: UICollectionView
    private var viewModels: [LocationViewModel] = []
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.hidesWhenStopped = true
        activity.color = .black
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    init(output: LocationViewOutput) {
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
// MARK: - LocationViewInput from Presenter
extension LocationViewController: LocationViewInput {
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
                    self.collectionView.setEmptyMessage(message: "Не найдено локаций")
                }
            }
        }
    }
    
    func set(viewModels: [LocationViewModel]) {
        self.viewModels = viewModels
        DispatchQueue.main.async {
            self.collectionView.restore()
            self.collectionView.reloadData()
        }
    }
}
//MARK: - Extensions CollectionsView
private extension LocationViewController {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(LocationCell.self)
    }
}
//MARK: - UICollectionViewDataSource
extension LocationViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: LocationCell.self, for: indexPath)
        let viewModel = viewModels[indexPath.row]
        cell.update(with: viewModel)
        return cell
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension LocationViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: view.bounds.width, spacing: LocationConstants.Layout.spacing)
        return CGSize(width: width, height: LocationConstants.Layout.heightCardDescription)
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing: CGFloat = (LocationConstants.Layout.itemsInRow * LocationConstants.Layout.spacingLeft + (LocationConstants.Layout.itemsInRow - 1) * LocationConstants.Layout.spacingRight) + LocationConstants.Layout.minimumInteritemSpacingForSectionAt - LocationConstants.Layout.spacing
        let finalWidth = (width - totalSpacing) / LocationConstants.Layout.itemsInRow
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
        return UIEdgeInsets(top: LocationConstants.Layout.spacingTop, left: LocationConstants.Layout.spacingLeft, bottom: LocationConstants.Layout.spacingBottom, right: LocationConstants.Layout.spacingRight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LocationConstants.Layout.spacingBottom
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LocationConstants.Layout.minimumInteritemSpacingForSectionAt
    }
}
//MARK: - activityIndicator
extension LocationViewController {
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
}