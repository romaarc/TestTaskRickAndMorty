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

protocol EpisodeDetailModuleOutput: AnyObject {
}

protocol EpisodeDetailViewInput: AnyObject {
}

protocol EpisodeDetailViewOutput: AnyObject {
}

protocol EpisodeDetailInteractorInput: AnyObject {
}

protocol EpisodeDetailInteractorOutput: AnyObject {
}

protocol EpisodeDetailRouterInput: AnyObject {
}
