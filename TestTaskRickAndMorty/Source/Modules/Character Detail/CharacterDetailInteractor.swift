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
    private var reachabilityService: ReachabilityProtocol
    private var persistentProvider: PersistentProviderProtocol
    private var episodes: [Episode] = []
    private var location: Location? = nil
    
    init(rickAndMortyNetworkService: NetworkServiceProtocol,
         reachabilityService: ReachabilityProtocol,
         persistentProvider: PersistentProviderProtocol) {
        self.rickAndMortyNetworkService = rickAndMortyNetworkService
        self.reachabilityService = reachabilityService
        self.persistentProvider = persistentProvider
    }
}

extension CharacterDetailInteractor: CharacterDetailInteractorInput {
    func reload(with episodes: [String], and location: String) {
        reachabilityService.isConnectedToNetwork() ? load(with: episodes, and: location) : loadOffline(with: episodes, and: location)
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
    func loadOffline(with episodes: [String], and location: String) {
        let resultsEpisodes = persistentProvider.fetchEpisodeModels(by: episodes)
        self.episodes = resultsEpisodes.map { epi in
            Episode(id: Int(epi.id),
                    name: epi.name,
                    airDate: epi.airDate,
                    episode: epi.episode,
                    characters: epi.characters ?? [String](),
                    created: epi.created,
                    url: epi.url)
        }
        
        let resultsLocation = persistentProvider.fetchLocationModel(by: location)
        if resultsLocation.isEmpty {
            output?.didLoad(with: self.episodes, and: self.location)
        } else {
            self.location = resultsLocation.first.map { location in
                Location(id: Int(location.id),
                         name: location.name,
                         type: location.type,
                         dimension: location.dimension,
                         residents: location.residents ?? [String](),
                         created: location.created,
                         url: location.url)
            }
            output?.didLoad(with: self.episodes, and: self.location)
        }
    }
}
