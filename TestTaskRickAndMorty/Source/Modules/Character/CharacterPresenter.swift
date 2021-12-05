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
    
    private var isNextPageLoading = false
    private var isReloading = false
    private var hasNextPage = true
    private var characters: [Character] = []
    
    init(router: CharacterRouterInput, interactor: CharacterInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CharacterPresenter: CharacterModuleInput {
}

extension CharacterPresenter: CharacterViewOutput {
    func viewDidLoad() {
        isReloading = true
        interactor.reload()
    }
    
}

extension CharacterPresenter: CharacterInteractorOutput {
    func didLoad(with characters: [Character], loadType: LoadingDataType) {
        switch loadType {
        case .reload:
            isReloading = false
            self.characters = characters
        case .nextPage:
            isNextPageLoading = false
            hasNextPage = characters.count > 0
            self.characters.append(contentsOf: characters)
        }
        let viewModels: [CharacterViewModel] = makeViewModels(self.characters)
        view?.set(viewModels: viewModels)
    }
    
    func didError(with error: Error) {
        print(error)
    }
}

private extension CharacterPresenter {
    func makeViewModels(_ characters: [Character]) -> [CharacterViewModel] {
        return characters.map { character in
            CharacterViewModel(id: character.id,
                               name: character.name,
                               status: character.status,
                               imageURL: character.imageURL)
        }
    }
}
