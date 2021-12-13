//
//  BaseViewController.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 13.12.2021.
//
import UIKit

class BaseViewController: UIViewController {
    
    var collectionView: UICollectionView
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.hidesWhenStopped = true
        activity.color = .black
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupUI()
    }

    func setupUI() {
        setupCollectionView()
    }
    
    func setupCollectionView() {}
}
//MARK: - activityIndicator
extension BaseViewController {
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
}
