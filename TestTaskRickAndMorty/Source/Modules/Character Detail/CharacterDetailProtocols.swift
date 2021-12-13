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
    func set(viewModels: [EpisodeViewModel], and location: LocationViewModel?)
    func didError()
    func stopActivityIndicator()
    func startActivityIndicator()
}

protocol CharacterDetailViewOutput: AnyObject {
    func showLocation(with location: LocationViewModel)
    func viewDidLoad(with episodes: [String], and location: String)
}

protocol CharacterDetailInteractorInput: AnyObject {
    func reload(with episodes: [String], and location: String)
}

protocol CharacterDetailInteractorOutput: AnyObject {
    func didLoad(with episodes: [Episode], and location: Location?)
    func didError(with error: Error)
}

protocol CharacterDetailRouterInput: AnyObject {
    func showLocation(with location: LocationViewModel)
}
