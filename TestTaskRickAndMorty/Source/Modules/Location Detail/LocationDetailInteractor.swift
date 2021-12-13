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
    private var residents: [Character] = []
    
    init(rickAndMortyNetworkService: NetworkServiceProtocol) {
        self.rickAndMortyNetworkService = rickAndMortyNetworkService
    }
}

extension LocationDetailInteractor: LocationDetailInteractorInput {
    func reload(with residents: [String]) {
        load(with: residents)
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
}
