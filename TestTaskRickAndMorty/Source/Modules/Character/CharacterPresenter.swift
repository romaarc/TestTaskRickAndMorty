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
    
    func willDisplay(at index: Int) {
        if !isReloading, !isNextPageLoading, index == (characters.count - 1), index != 0 {
            isNextPageLoading = true
            interactor.loadNext()
        } else {
            return
        }
    }
    
    func searchBarTextDidEndEditing(with text: String?) {
        guard let searchText = text else { return }
        characters.removeAll()
        isReloading = true
        isNextPageLoading = false
        interactor.reload(withParams: CharacterURLParameters(page: String(GlobalConstants.initialPage), name: searchText))
    }
    
    func searchBarCancelButtonClicked() {
        characters.removeAll()
        isReloading = true
        isNextPageLoading = false
        interactor.reload(withParams: CharacterURLParameters(page: String(GlobalConstants.initialPage)))
    }
    
    func onFilterButtonTap(withStatus status: String, withGender gender: String) {
        router.showFilter(withStatus: status, withGender: gender)
    }
    
    func didFilterTapped(withStatus status: String, withGender gender: String) {
        characters.removeAll()
        isReloading = true
        isNextPageLoading = false
        interactor.reloadFilter(withParams: CharacterURLParameters(page: String(GlobalConstants.initialPage),
                                                             status: status,
                                                             gender: gender))
    }
}

extension CharacterPresenter: CharacterInteractorOutput {
    func didLoad(with characters: [Character], loadType: LoadingDataType, isSearch: Bool) {
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
        view?.set(viewModels: viewModels, isSearch: isSearch)
    }
    
    func didError(with error: Error) {
        print(error)
        view?.didError()
    }
}

private extension CharacterPresenter {
    func makeViewModels(_ characters: [Character]) -> [CharacterViewModel] {
        return characters.map { character in
            CharacterViewModel(id: character.id,
                               name: character.name,
                               status: character.status,
                               imageURL: character.imageURL,
                               species: character.species)
        }
    }
}
