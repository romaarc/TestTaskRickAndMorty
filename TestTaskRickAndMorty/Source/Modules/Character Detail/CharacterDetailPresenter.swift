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

extension CharacterDetailPresenter: CharacterDetailViewOutput {
    func viewDidLoad(with episodes: [String], and location: String) {
        view?.startActivityIndicator()
        interactor.reload(with: episodes, and: location)
    }
    
    func showLocation(with location: LocationViewModel) {
        router.showLocation(with: location)
    }
    
    func showEpisode(with episode: EpisodeViewModel) {
        router.showEpisode(with: episode)
    }
}

extension CharacterDetailPresenter: CharacterDetailInteractorOutput {
    func didLoad(with episodes: [Episode], and location: Location?) {
        let viewModels: [EpisodeViewModel] = EpisodePresenter.makeViewModels(episodes)
        var locationViewModel: LocationViewModel? = nil
        if let location = location {
            locationViewModel = LocationPresenter.makeViewModel(location)
        }
        DispatchQueue.main.async {
            self.view?.stopActivityIndicator()
        }
        view?.set(viewModels: viewModels, and: locationViewModel)
    }
    
    func didError(with error: Error) {
        print(error)
        DispatchQueue.main.async {
            self.view?.stopActivityIndicator()
        }
        view?.didError()
    }
}
