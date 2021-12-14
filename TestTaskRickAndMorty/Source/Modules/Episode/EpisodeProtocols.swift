//
//  EpisodeProtocols.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import Foundation

protocol EpisodeModuleInput {
	var moduleOutput: EpisodeModuleOutput? { get }
}

protocol EpisodeModuleOutput: AnyObject {}

protocol EpisodeViewInput: ViewInput {
    func set(viewModels: [EpisodeViewModel], seasons: [Int: Int])
}

protocol EpisodeViewOutput: AnyObject {
    func viewDidLoad()
    func willDisplay(at index: Int, on section: Int)
    func onRowTap(with viewModel: EpisodeViewModel)
}

protocol EpisodeInteractorInput: InteractorInput {}

protocol EpisodeInteractorOutput: InteractorOutput {
    func didLoad(with episodes: [Episode], loadType: LoadingDataType, count: Int)
}

protocol EpisodeRouterInput: AnyObject {
    func showDetail(with viewModel: EpisodeViewModel)
}
