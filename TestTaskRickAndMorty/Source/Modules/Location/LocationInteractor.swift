//
//  LocationInteractor.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 10.12.2021.
//  
//

import Foundation

final class LocationInteractor {
    weak var output: LocationInteractorOutput?
    private let rickAndMortyNetworkService: NetworkServiceProtocol
    private let reachabilityService: ReachabilityProtocol
    private let persistentProvider: PersistentProviderProtocol
    private var page: Int = GlobalConstants.initialPage
    private var params: LocationURLParameters
        
    init(rickAndMortyNetworkService: NetworkServiceProtocol,
         reachabilityService: ReachabilityProtocol,
         persistentProvider: PersistentProviderProtocol) {
        self.rickAndMortyNetworkService = rickAndMortyNetworkService
        self.reachabilityService = reachabilityService
        self.persistentProvider = persistentProvider
        self.params = LocationURLParameters(page: String(self.page))
    }
}

extension LocationInteractor: LocationInteractorInput {
    func reload() {
        page = GlobalConstants.initialPage
        params = LocationURLParameters(page: String(page))
        reachabilityService.isConnectedToNetwork() ? load() : loadOffline()
    }
    
    func loadNext() {
        reachabilityService.isConnectedToNetwork() ? load() : loadOffline()
    }
}

private extension LocationInteractor {
    func load() {
        rickAndMortyNetworkService.fetchLocations(with: params) { [weak self] result  in
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
                
                let workItem = DispatchWorkItem {
                    self.persistentProvider.update(with: self.page > maxPage ? maxPage : self.page - 1, where: response.results, and: .add)
                    self.persistentProvider.update(with: maxPage, and: maxCount, where: .locations)
                }
                
                DispatchQueue.global(qos: .background).async(execute: workItem)
            case .failure(let error):
                self.output?.didError(with: error)
            }
        }
    }
    
    func loadOffline() {
        let results = persistentProvider.fetchLocationModels(with: page)
        let infoTable = persistentProvider.fetchInfoModels().first
        
        var locationsModels: [Location] = []
        locationsModels = results.map { location in
            Location(id: Int(location.id),
                     name: location.name,
                     type: location.type,
                     dimension: location.dimension,
                     residents: location.residents ?? [String](),
                     created: location.created,
                     url: location.url)
        }
        if !locationsModels.isEmpty {
            output?.didLoad(with: locationsModels, loadType: page == GlobalConstants.initialPage ? .reload : .nextPage, count: Int(infoTable?.locationCount ?? 0))
            
            if page == Int(infoTable?.locationPages ?? 0) {
                page = Int(infoTable?.locationPages ?? 0)
            } else {
                page += 1
            }
            params.page = String(page)
        } else {
            output?.didError(with: NetworkErrors.dataIsEmpty)
        }
    }
}
