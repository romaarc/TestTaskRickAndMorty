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
    func set(viewModels: [CharacterViewModel])
}

protocol EpisodeDetailViewOutput: AnyObject {
    func viewDidLoad(with characters: [String])
}

protocol EpisodeDetailInteractorInput: AnyObject {
    func reload(by characters: [String])
}

protocol EpisodeDetailInteractorOutput: InteractorOutput {
    func didLoad(with characters: [Character])
}

protocol EpisodeDetailRouterInput: AnyObject {}
