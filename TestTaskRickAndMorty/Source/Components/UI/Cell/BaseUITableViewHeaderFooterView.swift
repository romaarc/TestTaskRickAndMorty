//
//  BaseUITableViewHeaderFooterView.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 11.12.2021.
//

import UIKit

class BaseUITableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {}
}
