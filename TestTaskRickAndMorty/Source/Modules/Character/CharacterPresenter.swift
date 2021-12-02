//
//  CharacterPresenter.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//  
//

import Foundation

final class CharacterPresenter {
	weak var view: CharacterViewInput?
    weak var moduleOutput: CharacterModuleOutput?
    
	private let router: CharacterRouterInput
	private let interactor: CharacterInteractorInput
    
    init(router: CharacterRouterInput, interactor: CharacterInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CharacterPresenter: CharacterModuleInput {
}

extension CharacterPresenter: CharacterViewOutput {
}

extension CharacterPresenter: CharacterInteractorOutput {
}
