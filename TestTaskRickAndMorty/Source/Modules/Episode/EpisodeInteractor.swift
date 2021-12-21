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
    private var reachabilityService: ReachabilityProtocol
    private var persistentProvider: PersistentProviderProtocol
    private var page: Int = GlobalConstants.initialPage
    private var params: EpisodeURLParameters
    
    init(rickAndMortyNetworkService: NetworkServiceProtocol,
         reachabilityService: ReachabilityProtocol,
         persistentProvider: PersistentProviderProtocol) {
        self.rickAndMortyNetworkService = rickAndMortyNetworkService
        self.reachabilityService = reachabilityService
        self.persistentProvider = persistentProvider
        self.params = EpisodeURLParameters(page: String(self.page))
    }
}

extension EpisodeInteractor: EpisodeInteractorInput {
    func reload() {
        page = GlobalConstants.initialPage
        params = EpisodeURLParameters(page: String(page))
        reachabilityService.isConnectedToNetwork() ? load() : loadOffline()
    }
    
    func loadNext() {
        reachabilityService.isConnectedToNetwork() ? load() : loadOffline()
    }
}

private extension EpisodeInteractor {
    func load() {
        rickAndMortyNetworkService.fetchEpisodes(with: params) { [weak self] result  in
            guard let self = self else { return }
            switch result {
            case.success(let response):
                let maxPage = response.info.pages
                let maxCount = response.info.count
                var wasMax = false
                self.output?.didLoad(with: response.results, loadType: self.page == GlobalConstants.initialPage ? .reload : .nextPage, count: maxCount)
                if self.page == maxPage {
                    self.page = maxPage
                    wasMax = true
                } else {
                    self.page += 1
                }
                self.params.page = String(self.page)
                
                let workItem = DispatchWorkItem {
                    self.persistentProvider.update(with: wasMax ? maxPage : self.page - 1, where: response.results, and: .add)
                    self.persistentProvider.update(with: maxPage, and: maxCount, where: .episodes)
                }
                DispatchQueue.global(qos: .background).async(execute: workItem)
            case .failure(let error):
                self.output?.didError(with: error)
            }
        }
    }
    
    func loadOffline() {
        let results = persistentProvider.fetchEpisodeModels(with: page)
        let infoTable = persistentProvider.fetchInfoModels().first
        
        var episodesModels: [Episode] = []
        episodesModels = results.map { epi in
            Episode(id: Int(epi.id),
                    name: epi.name,
                    airDate: epi.airDate,
                    episode: epi.episode,
                    characters: epi.characters ?? [String](),
                    created: epi.created,
                    url: epi.url)
        }
        if !episodesModels.isEmpty {
            output?.didLoad(with: episodesModels, loadType: page == GlobalConstants.initialPage ? .reload : .nextPage, count: Int(infoTable?.episodeCount ?? 0))
            
            if page == Int(infoTable?.episodePages ?? 0) {
                page = Int(infoTable?.episodePages ?? 0)
            } else {
                page += 1
            }
            params.page = String(page)
        } else {
            output?.didError(with: NetworkErrors.dataIsEmpty)
        }
    }
}
