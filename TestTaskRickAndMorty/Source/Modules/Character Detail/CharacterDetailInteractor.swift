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
    private var location: Location? = nil
    
    init(rickAndMortyNetworkService: NetworkServiceProtocol) {
        self.rickAndMortyNetworkService = rickAndMortyNetworkService
    }
}

extension CharacterDetailInteractor: CharacterDetailInteractorInput {
    func reload(with episodes: [String], and location: String) {
        load(with: episodes, and: location)
    }
}

private extension CharacterDetailInteractor {
    func load(with episodes: [String], and location: String) {
        let queue = DispatchQueue.global(qos: .userInteractive)
        let group = DispatchGroup()
        
        if episodes.isEmpty {
            self.output?.didError(with: NetworkErrors.dataIsEmpty)
        } else {
            for episode in episodes {
                group.enter()
                rickAndMortyNetworkService.requestEpisode(with: episode) { [weak self] result in
                    defer { group.leave() }
                    guard let self = self else { return }
                    switch result {
                    case.success(let response):
                        self.episodes.append(response)
                    case .failure(let error):
                        self.output?.didError(with: error)
                    }
                }
            }
            group.notify(queue: queue) { [weak self] in
                guard let self = self else { return }
                if location.isEmpty {
                    self.output?.didLoad(with: self.episodes, and: self.location)
                } else {
                    self.rickAndMortyNetworkService.requestLocation(with: location) { [weak self] result in
                        guard let self = self else { return }
                        switch result {
                        case .success(let response):
                            self.location = response
                            if let location = self.location {
                                self.output?.didLoad(with: self.episodes, and: location)
                            }
                        case .failure(let error):
                            self.output?.didError(with: error)
                        }
                    }
                }
            }
        }
    }
}
