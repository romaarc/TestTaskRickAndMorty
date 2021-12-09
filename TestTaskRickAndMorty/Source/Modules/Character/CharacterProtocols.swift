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
    func set(viewModels: [CharacterViewModel], isSearch: Bool)
    func didError()
}

protocol CharacterViewOutput: AnyObject {
    func viewDidLoad()
    func searchBarTextDidEndEditing(with text: String?)
    func searchBarCancelButtonClicked()
    func willDisplay(at index: Int)
    func onFilterButtonTap()
}

protocol CharacterInteractorInput: AnyObject {
    func reload()
    func loadNext()
    func reload(withParams params: CharacterURLParameters)
}

protocol CharacterInteractorOutput: AnyObject {
    func didLoad(with characters: [Character], loadType: LoadingDataType, isSearch: Bool)
    func didError(with error: Error)
}

protocol CharacterRouterInput: AnyObject {
    func showFilter()
}
