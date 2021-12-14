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

protocol LocationDetailModuleOutput: AnyObject {}

protocol LocationDetailViewInput: ViewInput {
    func set(viewModels: [CharacterViewModel])
}

protocol LocationDetailViewOutput: AnyObject {
    func viewDidLoad(with residents: [String])
}

protocol LocationDetailInteractorInput: AnyObject {
    func reload(with residents: [String])
}

protocol LocationDetailInteractorOutput: InteractorOutput {
    func didLoad(with residents: [Character])
}

protocol LocationDetailRouterInput: AnyObject {}
