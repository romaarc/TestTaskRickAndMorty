//
//  EpisodePresenter.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import Foundation

final class EpisodePresenter {
	weak var view: EpisodeViewInput?
    weak var moduleOutput: EpisodeModuleOutput?
    
	private let router: EpisodeRouterInput
	private let interactor: EpisodeInteractorInput
    
    private var isNextPageLoading = false
    private var isReloading = false
    private var hasNextPage = true
    private var episodes: [Episode] = []
    private var count: Int = 0
    
    init(router: EpisodeRouterInput, interactor: EpisodeInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EpisodePresenter: EpisodeModuleInput {
}

extension EpisodePresenter: EpisodeViewOutput {
    func viewDidLoad() {
        isReloading = true
        interactor.reload()
    }
    
    func loadNext() {
        isNextPageLoading = true
        interactor.loadNext()
    }
    
    func willDisplay(at index: Int) {
        guard !isReloading, !isNextPageLoading, index == (episodes.count - 1), index >= 19, episodes.count != self.count else {
            return
        }
        isNextPageLoading = true
        interactor.loadNext()
    }
}

extension EpisodePresenter: EpisodeInteractorOutput {
    func didLoad(with episodes: [Episode], loadType: LoadingDataType, count: Int) {
        switch loadType {
        case .reload:
            isReloading = false
            self.episodes = episodes
        case .nextPage:
            isNextPageLoading = false
            hasNextPage = episodes.count > 0
            self.episodes.append(contentsOf: episodes)
        }
        self.count = count
        let viewModels: [EpisodeViewModel] = makeViewModels(self.episodes)
        view?.set(viewModels: viewModels, episodes: self.episodes)
    }
    
    func didError(with error: Error) {
        print(error)
        view?.didError()
    }
}

private extension EpisodePresenter {
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
