//
//  BaseUICollectionReusableView.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 12.12.2021.
//

import UIKit

class BaseUICollectionReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {}
}
