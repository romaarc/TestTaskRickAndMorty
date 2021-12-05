//
//  CharacterInteractor.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//  
//

import Foundation

final class CharacterInteractor {
    weak var output: CharacterInteractorOutput?
    
    private let rickAndMortyNetworkService: NetworkServiceProtocol
    
    private var page: Int = GlobalConstants.initialPage
    
    init(rickAndMortyNetworkService: NetworkServiceProtocol) {
        self.rickAndMortyNetworkService = rickAndMortyNetworkService
    }
}

extension CharacterInteractor: CharacterInteractorInput {
    func reload() {
        page = GlobalConstants.initialPage
        load()
    }
}

private extension CharacterInteractor {
    func load() {
        let params  = CharacterURLParameters(page: String(page), name: nil, status: nil, gender: nil)
        rickAndMortyNetworkService.requestCharacters(with: params) { [weak self] result  in
            guard let self = self else { return }
            switch result {
            case.success(let response):
                self.output?.didLoad(with: response.results, loadType: self.page == GlobalConstants.initialPage ? .reload : .nextPage)
                self.page += 1
            case .failure(let error):
                self.output?.didError(with: error)
            }
        }
    }
}
