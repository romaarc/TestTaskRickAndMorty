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
    private var reachabilityService: ReachabilityProtocol
    private var page: Int = GlobalConstants.initialPage
    private var params: CharacterURLParameters
    private var isSearch: Bool
    
    init(rickAndMortyNetworkService: NetworkServiceProtocol, reachabilityService: ReachabilityProtocol) {
        self.rickAndMortyNetworkService = rickAndMortyNetworkService
        self.reachabilityService = reachabilityService
        self.params = CharacterURLParameters(page: String(self.page))
        self.isSearch = false
    }
}

extension CharacterInteractor: CharacterInteractorInput {
    func reload() {
        if reachabilityService.isConnectedToNetwork() {
            isSearch = false
            page = GlobalConstants.initialPage
            params = CharacterURLParameters(page: String(self.page))
            load()
        } else {
            print("хуй")
        }
    }
    
    func loadNext() {
        if reachabilityService.isConnectedToNetwork() {
            isSearch = false
            load()
        } else {
            print("хуй")
        }
    }
    
    func reload(withParams params: CharacterURLParameters) {
        isSearch = true
        page = GlobalConstants.initialPage
        self.params = params
        load()
    }
    
    func reloadFilter(withParams params: CharacterURLParameters) {
        isSearch = true
        page = GlobalConstants.initialPage
        self.params = params
        load()
    }
}

private extension CharacterInteractor {
    func load() {
        rickAndMortyNetworkService.requestCharacters(with: params) { [weak self] result  in
            guard let self = self else { return }
            switch result {
            case.success(let response):
                let maxPage = response.info.pages
                let maxCount = response.info.count
                self.output?.didLoad(with: response.results, loadType: self.page == GlobalConstants.initialPage ? .reload : .nextPage, count: maxCount, isSearch: self.isSearch)
                if self.page == maxPage {
                    self.page = maxPage
                } else {
                    self.page += 1
                }
                self.params.page = String(self.page)
            case .failure(let error):
                self.output?.didError(with: error)
            }
        }
    }
}
