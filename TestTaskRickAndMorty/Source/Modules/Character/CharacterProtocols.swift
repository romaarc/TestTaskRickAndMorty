//
//  CharacterProtocols.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//  
//

import Foundation

protocol CharacterModuleInput {
	var moduleOutput: CharacterModuleOutput? { get }
}

protocol CharacterModuleOutput: AnyObject {
}

protocol CharacterViewInput: AnyObject {
}

protocol CharacterViewOutput: AnyObject {
}

protocol CharacterInteractorInput: AnyObject {
}

protocol CharacterInteractorOutput: AnyObject {
}

protocol CharacterRouterInput: AnyObject {
}
