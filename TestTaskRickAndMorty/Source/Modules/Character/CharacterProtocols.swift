//
//  CharacterProtocols.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//  
//

import Foundation

enum LoadingDataType {
    case nextPage
    case reload
}

protocol CharacterModuleInput {
	var moduleOutput: CharacterModuleOutput? { get }
}

protocol CharacterModuleOutput: AnyObject {
}

protocol CharacterViewInput: AnyObject {
    func set(viewModels: [CharacterViewModel])
}

protocol CharacterViewOutput: AnyObject {
    func viewDidLoad()
    func willDisplay(at index: Int)
}

protocol CharacterInteractorInput: AnyObject {
    func reload()
    func loadNext()
}

protocol CharacterInteractorOutput: AnyObject {
    func didLoad(with characters: [Character], loadType: LoadingDataType)
    func didError(with error: Error)
}

protocol CharacterRouterInput: AnyObject {
}
