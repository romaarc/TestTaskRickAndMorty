//
//  EpisodeDetailViewController.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 12.12.2021.
//  
//

import UIKit

final class EpisodeDetailViewController: BaseViewController {
	private let output: EpisodeDetailViewOutput

    init(output: EpisodeDetailViewOutput) {
        self.output = output
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension EpisodeDetailViewController: EpisodeDetailViewInput {}
