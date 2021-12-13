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
    private var episodes: [Episode] = []
    
    init(rickAndMortyNetworkService: NetworkServiceProtocol) {
        self.rickAndMortyNetworkService = rickAndMortyNetworkService
    }
}

extension CharacterDetailInteractor: CharacterDetailInteractorInput {
    func reload(with episodes: [String]) {
        load(with: episodes)
    }
}

private extension CharacterDetailInteractor {
    func load(with episodes: [String]) {
        if episodes.isEmpty {
            self.output?.didError(with: NetworkErrors.dataIsEmpty)
        } else {
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
}
