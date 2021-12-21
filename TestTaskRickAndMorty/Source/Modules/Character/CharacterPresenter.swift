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
    
    func searchBarTextDidEndEditing(with searchText: String, and filter: Filter) {
        view?.startActivityIndicator()
        characters.removeAll()
        isReloading = false
        isNextPageLoading = false
        var status = ""
        var gender = ""
        if let indexPath = filter.statusIndexPath {
            status = filter.statusCharacters[indexPath.row]
        }
        if let indexPath = filter.genderIndexPath {
            gender = filter.genderCharacters[indexPath.row]
        }
        interactor.reload(withParams: CharacterURLParameters(page: String(GlobalConstants.initialPage),
                                                             name: searchText,
                                                             status: status,
                                                             gender: gender))
    }
    
    func searchBarCancelButtonClicked() {
        view?.startActivityIndicator()
        characters.removeAll()
        isReloading = false
        isNextPageLoading = false
        interactor.reload(withParams: CharacterURLParameters(page: String(GlobalConstants.initialPage)))
    }
    
    func onFilterButtonTap(with filter: Filter) {
        router.showFilter(with: filter)
    }
    
    func didFilterTapped(with filter: Filter) {
        view?.startActivityIndicator()
        characters.removeAll()
        isReloading = false
        isNextPageLoading = false
        var status = ""
        var gender = ""
        if let indexPath = filter.statusIndexPath {
            status = filter.statusCharacters[indexPath.row]
        }
        if let indexPath = filter.genderIndexPath {
            gender = filter.genderCharacters[indexPath.row]
        }
        interactor.reload(withParams: CharacterURLParameters(page: String(GlobalConstants.initialPage),
                                                             status: status,
                                                             gender: gender))
    }
    
    func onCellTap(with viewModel: CharacterViewModel) {
        router.showDetail(with: viewModel)
    }
}

extension CharacterPresenter: CharacterInteractorOutput {
    func didLoad(with characters: [Character], loadType: LoadingDataType, count: Int, isOffline: Bool) {
        switch loadType {
        case .reload:
            isReloading = false
            self.characters = characters
        case .nextPage:
            isNextPageLoading = false
            self.characters.append(contentsOf: characters)
        }
        self.count = count
        let viewModels: [CharacterViewModel] = CharacterPresenter.makeViewModels(self.characters.sorted {$0.id < $1.id} )
        DispatchQueue.main.async {
            self.view?.stopActivityIndicator()
        }
        view?.set(viewModels: viewModels, isOffline: isOffline)
    }
    
    func didError(with error: Error) {
        print(error)
        DispatchQueue.main.async {
            self.view?.stopActivityIndicator()
        }
        view?.didError()
    }
    
    func change(loadType: LoadingDataType, isOffline: Bool) {
        switch loadType {
        case .nextPage:
            isNextPageLoading = false
        case .reload:
            isReloading = false
        }
    }
}

extension CharacterPresenter {
    static func makeViewModels(_ characters: [Character]) -> [CharacterViewModel] {
        return characters.map { character in
            CharacterViewModel(id: character.id,
                               name: character.name,
                               gender: character.gender,
                               status: character.status.capitalized,
                               imageURL: character.imageURL,
                               species: character.species,
                               type: character.type,
                               origin: character.origin,
                               location: character.location,
                               episodes: character.episode)
        }
    }
}
