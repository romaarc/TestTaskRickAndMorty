//
//  EpisodeDetailPresenter.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 12.12.2021.
//  
//

import Foundation

final class EpisodeDetailPresenter {
	weak var view: EpisodeDetailViewInput?
    weak var moduleOutput: EpisodeDetailModuleOutput?
    private var characters: [Character] = []
    
	private let router: EpisodeDetailRouterInput
	private let interactor: EpisodeDetailInteractorInput
    
    init(router: EpisodeDetailRouterInput, interactor: EpisodeDetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EpisodeDetailPresenter: EpisodeDetailModuleInput {
}

extension EpisodeDetailPresenter: EpisodeDetailViewOutput {
    func viewDidLoad(with characters: [String]) {
        view?.startActivityIndicator()
        interactor.reload(with: characters)
    }
}

extension EpisodeDetailPresenter: EpisodeDetailInteractorOutput {
    func didLoad(with characters: [Character]) {
        let viewModels: [CharacterViewModel] = CharacterPresenter.makeViewModels(characters)
        DispatchQueue.main.async {
            self.view?.stopActivityIndicator()
        }
        view?.set(viewModels: viewModels)
    }
    
    func didError(with error: Error) {
        print(error)
        DispatchQueue.main.async {
            self.view?.stopActivityIndicator()
        }
        view?.didError()
    }
}
