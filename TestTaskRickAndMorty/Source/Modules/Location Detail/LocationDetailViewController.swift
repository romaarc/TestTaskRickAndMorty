//
//  LocationDetailViewController.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 12.12.2021.
//  
//

import UIKit

final class LocationDetailViewController: UIViewController {
	private let output: LocationDetailViewOutput

    init(output: LocationDetailViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension LocationDetailViewController: LocationDetailViewInput {
}
