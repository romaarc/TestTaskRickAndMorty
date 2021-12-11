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

protocol EpisodeViewInput: AnyObject {
    func set(viewModels: [EpisodeViewModel], seasons: [Int: Int])
    func didError()
    func stopActivityIndicator()
    func startActivityIndicator()
}

protocol EpisodeViewOutput: AnyObject {
    func viewDidLoad()
    func willDisplay(at index: Int, on section: Int)
}

protocol EpisodeInteractorInput: AnyObject {
    func reload()
    func loadNext()
}

protocol EpisodeInteractorOutput: AnyObject {
    func didLoad(with episodes: [Episode], loadType: LoadingDataType, count: Int)
    func didError(with error: Error)
}

protocol EpisodeRouterInput: AnyObject {}
