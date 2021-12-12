//
//  CharacterDetailInteractor.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import Foundation

final class CharacterDetailInteractor {
	weak var output: CharacterDetailInteractorOutput?
    private let rickAndMortyNetworkService: NetworkServiceProtocol
    private var page: Int = GlobalConstants.initialPage
    private var params: EpisodeURLParameters
    private var episodes: [Episode] = []
    
    init(rickAndMortyNetworkService: NetworkServiceProtocol) {
        self.rickAndMortyNetworkService = rickAndMortyNetworkService
        self.params = EpisodeURLParameters(page: String(self.page))
    }
}

extension CharacterDetailInteractor: CharacterDetailInteractorInput {
    func reload(with episodes: [String]) {
        load(with: episodes)
    }
}

private extension CharacterDetailInteractor {
    func load(with episodes: [String]) {
        for (index, episode) in episodes.enumerated() {
            rickAndMortyNetworkService.requestEpisode(with: episode) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case.success(let response):
                    self.episodes.append(response)
                    if index == episodes.count - 1 {
                        self.output?.didLoad(with: self.episodes)
                    }
                case .failure(let error):
                    self.output?.didError(with: error)
                }
            }
        }
    }
}
