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
    private var params: CharacterURLParameters
    
    init(rickAndMortyNetworkService: NetworkServiceProtocol) {
        self.rickAndMortyNetworkService = rickAndMortyNetworkService
        self.params = CharacterURLParameters(page: String(page),
                                             name: nil,
                                             status: nil,
                                             gender: nil)
    }
}

extension CharacterInteractor: CharacterInteractorInput {
    func reload() {
        if params.page != "1" {
            page = GlobalConstants.initialPage
            params.page = String(page)
        }
        params.name = nil
        params.status = nil
        params.gender = nil
        load()
    }
    
    func loadNext() {
        load()
    }
    
    func reload(with searchText: String?) {
        guard let searchText = searchText else { return }
        page = GlobalConstants.initialPage
        params.page = String(page)
        params.name = searchText
        load()
    }
}

private extension CharacterInteractor {
    func load() {
        rickAndMortyNetworkService.requestCharacters(with: params) { [weak self] result  in
            guard let self = self else { return }
            switch result {
            case.success(let response):
                self.output?.didLoad(with: response.results, loadType: self.page == GlobalConstants.initialPage ? .reload : .nextPage)
                self.page += 1
                self.params.page = String(self.page)
            case .failure(let error):
                self.output?.didError(with: error)
            }
        }
    }
}
