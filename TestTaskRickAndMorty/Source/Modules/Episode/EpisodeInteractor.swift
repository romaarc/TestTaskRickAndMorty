//
//  EpisodeInteractor.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import Foundation

final class EpisodeInteractor {
	weak var output: EpisodeInteractorOutput?
    private let rickAndMortyNetworkService: NetworkServiceProtocol
    private var page: Int = GlobalConstants.initialPage
    private var params: EpisodeURLParameters
    
    init(rickAndMortyNetworkService: NetworkServiceProtocol) {
        self.rickAndMortyNetworkService = rickAndMortyNetworkService
        self.params = EpisodeURLParameters(page: String(self.page))
    }
}

extension EpisodeInteractor: EpisodeInteractorInput {
    func reload() {
        page = GlobalConstants.initialPage
        params = EpisodeURLParameters(page: String(page))
        load()
    }
    
    func loadNext() {
        load()
    }
}

private extension EpisodeInteractor {
    func load() {
        rickAndMortyNetworkService.requestEpisodes(with: params) { [weak self] result  in
            guard let self = self else { return }
            switch result {
            case.success(let response):
                let maxPage = response.info.pages
                let maxCount = response.info.count
                self.output?.didLoad(with: response.results, loadType: self.page == GlobalConstants.initialPage ? .reload : .nextPage, count: maxCount)
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
