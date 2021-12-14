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
    private var characters: [Character] = []
    
    init(rickAndMortyNetworkService: NetworkServiceProtocol) {
        self.rickAndMortyNetworkService = rickAndMortyNetworkService
    }
}

extension EpisodeDetailInteractor: EpisodeDetailInteractorInput {
    func reload(with characters: [String]) {
        load(with: characters)
    }
}

private extension EpisodeDetailInteractor {
    func load(with characters: [String]) {
        if characters.isEmpty {
            self.output?.didError(with: NetworkErrors.dataIsEmpty)
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
}

