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

protocol CharacterDetailViewInput: AnyObject {}

protocol CharacterDetailViewOutput: AnyObject {}

protocol CharacterDetailInteractorInput: AnyObject {}

protocol CharacterDetailInteractorOutput: AnyObject {}

protocol CharacterDetailRouterInput: AnyObject {}
