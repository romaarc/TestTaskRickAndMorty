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
    private var episodes: [Episode] = []
    private var dictEpisodes: [Int: Int] = [:]
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
        view?.startActivityIndicator()
        isReloading = true
        interactor.reload()
    }
    
    func loadNext() {
        view?.startActivityIndicator()
        isNextPageLoading = true
        interactor.loadNext()
    }
    
    func willDisplay(at index: Int, on section: Int) {
        guard let countEpisodesOfSeason = dictEpisodes[section] else { return }
        guard !isReloading, !isNextPageLoading, index == (countEpisodesOfSeason - 1), episodes.count != self.count else {
            return
        }
        view?.startActivityIndicator()
        isNextPageLoading = true
        interactor.loadNext()
    }
    
    func onRowTap(with viewModel: EpisodeViewModel) {
        router.showDetail(with: viewModel)
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
            self.episodes.append(contentsOf: episodes)
        }
        let episodesSeason = self.episodes.map({ String($0.episode.dropLast(3)) })
        let seasons = Array(Set(episodesSeason)).sorted()
        for (index, season) in seasons.enumerated() {
            dictEpisodes[index] = episodesSeason.filter({ $0.contains(season) }).count
        }
        self.count = count
        let viewModels: [EpisodeViewModel] = EpisodePresenter.makeViewModels(self.episodes)
        DispatchQueue.main.async {
            self.view?.stopActivityIndicator()
        }
        view?.set(viewModels: viewModels, seasons: dictEpisodes)
    }
    
    func didError(with error: Error) {
        print(error)
        DispatchQueue.main.async {
            self.view?.stopActivityIndicator()
        }
        view?.didError()
    }
}

extension EpisodePresenter {
    static func makeViewModels(_ episodes: [Episode]) -> [EpisodeViewModel] {
        return episodes.map { epi in
            EpisodeViewModel(id: epi.id,
                             name: epi.name,
                             airDate: epi.airDate,
                             episode: epi.episode,
                             characters: epi.characters,
                             created: epi.created)
        }
    }
}
