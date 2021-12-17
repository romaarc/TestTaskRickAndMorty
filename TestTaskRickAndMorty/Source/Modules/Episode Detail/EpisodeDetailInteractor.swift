//
//  EpisodeDetailInteractor.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 12.12.2021.
//  
//

import Foundation

final class EpisodeDetailInteractor {
	weak var output: EpisodeDetailInteractorOutput?
    private let rickAndMortyNetworkService: NetworkServiceProtocol
    private var reachabilityService: ReachabilityProtocol
    private var persistentProvider: PersistentProviderProtocol
    private var characters: [Character] = []
    
    init(rickAndMortyNetworkService: NetworkServiceProtocol,
         reachabilityService: ReachabilityProtocol,
         persistentProvider: PersistentProviderProtocol) {
        self.rickAndMortyNetworkService = rickAndMortyNetworkService
        self.reachabilityService = reachabilityService
        self.persistentProvider = persistentProvider
    }
}

extension EpisodeDetailInteractor: EpisodeDetailInteractorInput {
    func reload(with characters: [String]) {
        reachabilityService.isConnectedToNetwork() ? load(with: characters) : loadOffline(with: characters)
    }
}

private extension EpisodeDetailInteractor {
    func load(with characters: [String]) {
        if characters.isEmpty {
            output?.didError(with: NetworkErrors.dataIsEmpty)
        } else {
            for (index, character) in characters.enumerated() {
                rickAndMortyNetworkService.requestCharacter(with: character) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case.success(let response):
                        self.characters.append(response)
                        if index == characters.count - 1 {
                            self.output?.didLoad(with: self.characters)
                        }
                    case .failure(let error):
                        self.output?.didError(with: error)
                    }
                }
            }
        }
    }
    
    func loadOffline(with characters: [String]) {
        let results = persistentProvider.fetchCharactersModels(by: characters)
        if results.isEmpty {
            output?.didError(with: NetworkErrors.dataIsEmpty)
        } else {
            for result in results {
                let dictOrigin = result.origin
                let key = Array(dictOrigin.keys)[0]
                let origin = Origin(name: key,
                                    url: dictOrigin[key] ?? "")
                
                let dictLocation = result.location
                let locationKey = Array(dictLocation.keys)[0]
                let location = CharacterLocation(name: locationKey,
                                                 url: dictLocation[locationKey] ?? "")
                
                self.characters.append(Character(id: Int(result.id),
                                                  name: result.name,
                                                  status: result.status,
                                                  species: result.species,
                                                  type: result.type,
                                                  gender: result.gender,
                                                  origin: origin,
                                                  location: location,
                                                  episode: result.episode,
                                                  imageURL: result.image,
                                                  created: result.created,
                                                  url: result.url))
            }
            output?.didLoad(with: self.characters)
        }
    }
}
