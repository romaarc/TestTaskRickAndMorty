//
//  CharacterDetailProtocols.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import Foundation

protocol CharacterDetailModuleInput {
	var moduleOutput: CharacterDetailModuleOutput? { get }
}

protocol CharacterDetailModuleOutput: AnyObject {}

protocol CharacterDetailViewInput: AnyObject {
    func set(viewModels: [EpisodeViewModel])
    func didError()
    func stopActivityIndicator()
    func startActivityIndicator()
}

protocol CharacterDetailViewOutput: AnyObject {
    func viewDidLoad(with episodes: [String])
}

protocol CharacterDetailInteractorInput: AnyObject {
    func reload(with episodes: [String])
}

protocol CharacterDetailInteractorOutput: AnyObject {
    func didLoad(with episodes: [Episode])
    func didError(with error: Error)
}

protocol CharacterDetailRouterInput: AnyObject {}
