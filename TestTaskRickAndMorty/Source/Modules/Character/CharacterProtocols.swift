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

protocol CharacterViewInput: ViewInput {
    func set(viewModels: [CharacterViewModel], isSearch: Bool)
}

protocol CharacterViewOutput: AnyObject {
    func viewDidLoad()
    func searchBarTextDidEndEditing(with searchText: String, withStatus status: String, withGender gender: String)
    func searchBarCancelButtonClicked()
    func willDisplay(at index: Int)
    func onFilterButtonTap(withStatus status: String, withGender gender: String)
    func didFilterTapped(withStatus status: String, withGender gender: String)
    func onCellTap(with viewModel: CharacterViewModel)
}

protocol CharacterInteractorInput: InteractorInput {
    func reload(withParams params: CharacterURLParameters)
    func reloadFilter(withParams params: CharacterURLParameters)
}

protocol CharacterInteractorOutput: InteractorOutput {
    func didLoad(with characters: [Character], loadType: LoadingDataType, count: Int, isSearch: Bool)
}

protocol CharacterRouterInput: AnyObject {
    func showDetail(with viewModel: CharacterViewModel)
    func showFilter(withStatus status: String, withGender gender: String)
}
