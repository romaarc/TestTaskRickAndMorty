//
//  EpisodeDetailProtocols.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 12.12.2021.
//  
//

import Foundation

protocol EpisodeDetailModuleInput {
	var moduleOutput: EpisodeDetailModuleOutput? { get }
}

protocol EpisodeDetailModuleOutput: AnyObject {}

protocol EpisodeDetailViewInput: ViewInput {
//    func set(viewModels: [EpisodeViewModel])
}

protocol EpisodeDetailViewOutput: AnyObject {
}

protocol EpisodeDetailInteractorInput: AnyObject {
}

protocol EpisodeDetailInteractorOutput: InteractorOutput {
}

protocol EpisodeDetailRouterInput: AnyObject {}
