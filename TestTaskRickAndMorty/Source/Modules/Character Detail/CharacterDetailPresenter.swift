//
//  CharacterDetailPresenter.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import Foundation

final class CharacterDetailPresenter {
	weak var view: CharacterDetailViewInput?
    weak var moduleOutput: CharacterDetailModuleOutput?
    
	private let router: CharacterDetailRouterInput
	private let interactor: CharacterDetailInteractorInput
    
    init(router: CharacterDetailRouterInput, interactor: CharacterDetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CharacterDetailPresenter: CharacterDetailModuleInput {}

extension CharacterDetailPresenter: CharacterDetailViewOutput {}

extension CharacterDetailPresenter: CharacterDetailInteractorOutput {}
