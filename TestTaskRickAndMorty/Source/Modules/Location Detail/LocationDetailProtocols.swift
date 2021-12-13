//
//  LocationDetailProtocols.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 12.12.2021.
//  
//

import Foundation

protocol LocationDetailModuleInput {
	var moduleOutput: LocationDetailModuleOutput? { get }
}

protocol LocationDetailModuleOutput: AnyObject {
}

protocol LocationDetailViewInput: AnyObject {
    func set(viewModels: [CharacterViewModel])
    func didError()
    func stopActivityIndicator()
    func startActivityIndicator()
}

protocol LocationDetailViewOutput: AnyObject {
    func viewDidLoad(with residents: [String])
}

protocol LocationDetailInteractorInput: AnyObject {
    func reload(with residents: [String])
}

protocol LocationDetailInteractorOutput: AnyObject {
    func didLoad(with residents: [Character])
    func didError(with error: Error)
}

protocol LocationDetailRouterInput: AnyObject {
}
