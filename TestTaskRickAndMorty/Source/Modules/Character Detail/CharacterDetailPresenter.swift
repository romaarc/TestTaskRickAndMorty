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
    private var episodes: [Episode] = []
    
    init(router: CharacterDetailRouterInput, interactor: CharacterDetailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CharacterDetailPresenter: CharacterDetailModuleInput {}

extension CharacterDetailPresenter: CharacterDetailViewOutput {
    func viewDidLoad(with episodes: [String]) {
        view?.startActivityIndicator()
        interactor.reload(with: episodes)
    }
}

extension CharacterDetailPresenter: CharacterDetailInteractorOutput {
    func didLoad(with episodes: [Episode]) {
        self.episodes = episodes
        let viewModels: [EpisodeViewModel] = makeViewModels(self.episodes)
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
private extension CharacterDetailPresenter {
    func makeViewModels(_ episodes: [Episode]) -> [EpisodeViewModel] {
        return episodes.map { epi in
            EpisodeViewModel(id: epi.id,
                              name: epi.name,
                              airDate: epi.airDate,
                              episode: epi.episode,
                              created: epi.created)
        }
    }
}
