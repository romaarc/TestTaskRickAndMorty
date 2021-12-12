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
    private var count: Int = 0
    
    init(router: CharacterRouterInput, interactor: CharacterInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CharacterPresenter: CharacterModuleInput {}

extension CharacterPresenter: CharacterViewOutput {
    func viewDidLoad() {
        view?.startActivityIndicator()
        isReloading = true
        interactor.reload()
    }
    
    func willDisplay(at index: Int) {
        guard !isReloading, !isNextPageLoading, index == (characters.count - 1), index >= 19, characters.count != self.count else {
            return
        }
        view?.startActivityIndicator()
        isNextPageLoading = true
        interactor.loadNext()
    }
    
    func searchBarTextDidEndEditing(with searchText: String, withStatus status: String, withGender gender: String) {
        view?.startActivityIndicator()
        characters.removeAll()
        isReloading = true
        isNextPageLoading = false
        interactor.reload(withParams: CharacterURLParameters(page: String(GlobalConstants.initialPage),
                                                             name: searchText,
                                                             status: status,
                                                             gender: gender))
    }
    
    func searchBarCancelButtonClicked() {
        view?.startActivityIndicator()
        characters.removeAll()
        isReloading = true
        isNextPageLoading = false
        interactor.reload(withParams: CharacterURLParameters(page: String(GlobalConstants.initialPage)))
    }
    
    func onFilterButtonTap(withStatus status: String, withGender gender: String) {
        router.showFilter(withStatus: status, withGender: gender)
    }
    
    func didFilterTapped(withStatus status: String, withGender gender: String) {
        view?.startActivityIndicator()
        characters.removeAll()
        isReloading = true
        isNextPageLoading = false
        interactor.reloadFilter(withParams: CharacterURLParameters(page: String(GlobalConstants.initialPage),
                                                             status: status,
                                                             gender: gender))
    }
    
    func onCellTap(with viewModel: CharacterViewModel) {
        router.showDetail(with: viewModel)
    }
}

extension CharacterPresenter: CharacterInteractorOutput {
    func didLoad(with characters: [Character], loadType: LoadingDataType, count: Int, isSearch: Bool) {
        switch loadType {
        case .reload:
            isReloading = false
            self.characters = characters
        case .nextPage:
            isNextPageLoading = false
            hasNextPage = characters.count > 0
            self.characters.append(contentsOf: characters)
        }
        self.count = count
        let viewModels: [CharacterViewModel] = makeViewModels(self.characters)
        DispatchQueue.main.async {
            self.view?.stopActivityIndicator()
        }
        view?.set(viewModels: viewModels, isSearch: isSearch)
    }
    
    func didError(with error: Error) {
        print(error)
        DispatchQueue.main.async {
            self.view?.stopActivityIndicator()
        }
        view?.didError()
    }
}

private extension CharacterPresenter {
    func makeViewModels(_ characters: [Character]) -> [CharacterViewModel] {
        return characters.map { character in
            CharacterViewModel(id: character.id,
                               name: character.name,
                               gender: character.gender,
                               status: character.status,
                               imageURL: character.imageURL,
                               species: character.species,
                               type: character.type,
                               origin: character.origin,
                               location: character.location,
                               episodes: character.episode)
        }
    }
}
