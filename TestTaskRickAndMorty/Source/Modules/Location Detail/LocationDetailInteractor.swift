//
//  LocationDetailInteractor.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 12.12.2021.
//  
//

import Foundation

final class LocationDetailInteractor {
	weak var output: LocationDetailInteractorOutput?
    private let rickAndMortyNetworkService: NetworkServiceProtocol
    private var reachabilityService: ReachabilityProtocol
    private var persistentProvider: PersistentProviderProtocol
    private var residents: [Character] = []
    
    init(rickAndMortyNetworkService: NetworkServiceProtocol,
         reachabilityService: ReachabilityProtocol,
         persistentProvider: PersistentProviderProtocol) {
        self.rickAndMortyNetworkService = rickAndMortyNetworkService
        self.reachabilityService = reachabilityService
        self.persistentProvider = persistentProvider
    }
}

extension LocationDetailInteractor: LocationDetailInteractorInput {
    func reload(with residents: [String]) {
        reachabilityService.isConnectedToNetwork() ? load(with: residents) : loadOffline(with: residents)
    }
}

private extension LocationDetailInteractor {
    func load(with residents: [String]) {
        if residents.isEmpty {
            self.output?.didError(with: NetworkErrors.dataIsEmpty)
        } else {
            for (index, resident) in residents.enumerated() {
                rickAndMortyNetworkService.requestCharacter(with: resident) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case.success(let response):
                        self.residents.append(response)
                        if index == residents.count - 1 {
                            self.output?.didLoad(with: self.residents)
                        }
                    case .failure(let error):
                        self.output?.didError(with: error)
                    }
                }
            }
        }
    }
    
    func loadOffline(with residents: [String]) {
        let results = persistentProvider.fetchCharactersModels(by: residents)
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
                
                self.residents.append(Character(id: Int(result.id),
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
            output?.didLoad(with: self.residents)
        }
    }
}
