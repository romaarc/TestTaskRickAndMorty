//
//  CharacterInteractor.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 01.12.2021.
//  
//

import Foundation
import UIKit

final class CharacterInteractor {
    weak var output: CharacterInteractorOutput?
    private let rickAndMortyNetworkService: NetworkServiceProtocol
    private var reachabilityService: ReachabilityProtocol
    private var persistentProvider: PersistentProviderProtocol
    private var page: Int = GlobalConstants.initialPage
    private var params: CharacterURLParameters
    
    init(rickAndMortyNetworkService: NetworkServiceProtocol,
         reachabilityService: ReachabilityProtocol,
         persistentProvider: PersistentProviderProtocol) {
        self.rickAndMortyNetworkService = rickAndMortyNetworkService
        self.reachabilityService = reachabilityService
        self.persistentProvider = persistentProvider
        self.params = CharacterURLParameters(page: String(self.page))
    }
}

extension CharacterInteractor: CharacterInteractorInput {
    func reload() {
        page = GlobalConstants.initialPage
        params = CharacterURLParameters(page: String(self.page))
        reachabilityService.isConnectedToNetwork() ? load() : loadOffline()
    }
    
    func loadNext() {
        if self.params.name == nil, let paramsGender = self.params.gender, let paramsStatus = self.params.status {
            if  !paramsGender.isEmpty || !paramsStatus.isEmpty {
                reachabilityService.isConnectedToNetwork() ? load() : loadOfflineWithParams()
            } else {
                reachabilityService.isConnectedToNetwork() ? load() : loadOffline()
            }
        } else if let _ = self.params.name {
            reachabilityService.isConnectedToNetwork() ? load() : loadOfflineWithParams()
        } else {
            reachabilityService.isConnectedToNetwork() ? load() : loadOffline()
        }
    }
    
    func reload(withParams params: CharacterURLParameters) {
        page = GlobalConstants.initialPage
        self.params = params
        reachabilityService.isConnectedToNetwork() ? load() : loadOfflineWithParams()
    }
}

private extension CharacterInteractor {
    func load() {
        rickAndMortyNetworkService.fetchCharacters(with: params) { [weak self] result  in
            guard let self = self else { return }
            switch result {
            case.success(let response):
                let maxPage = response.info.pages
                let maxCount = response.info.count
                var wasMax = false
                self.output?.didLoad(with: response.results, loadType: self.page == GlobalConstants.initialPage ? .reload : .nextPage, count: maxCount, isOffline: false)
                if self.page == maxPage {
                    self.page = maxPage
                    wasMax = true
                } else {
                    self.page += 1
                }
                self.params.page = String(self.page)
                
                let workItem = DispatchWorkItem {
                    if self.params.name == nil, let paramsGender = self.params.gender, let paramsStatus = self.params.status {
                        if !paramsGender.isEmpty || !paramsStatus.isEmpty || ((self.params.name?.isEmpty) != nil) {
                            self.persistentProvider.updateFilter(with: wasMax ? maxPage : self.page - 1, where: response.results, and: self.params, to: .add) { _ in
                            }
                        } else {
                            self.persistentProvider.update(with: wasMax ? maxPage : self.page - 1, where: response.results, to: .add) { _ in
                            }
                            self.persistentProvider.update(with: maxPage, and: maxCount, where: .characters)
                        }
                    } else if let _ = self.params.name {
                        self.persistentProvider.updateFilter(with: 0, where: response.results, and: self.params, to: .add) { _ in
                        }
                    } else {
                        self.persistentProvider.update(with: wasMax ? maxPage : self.page - 1, where: response.results, to: .add) { _ in
                        }
                        self.persistentProvider.update(with: maxPage, and: maxCount, where: .characters)
                    }
                }
                DispatchQueue.global(qos: .background).async(execute: workItem)
            case .failure(let error):
                self.output?.didError(with: error)
            }
        }
    }
    
    func loadOffline() {
        let results = persistentProvider.fetchCharactersModels(with: page)
        let infoTable = persistentProvider.fetchInfoModels().first
        
        var charactersModels: [Character] = []
        
        for result in results {
            let dictOrigin = result.origin
            let key = Array(dictOrigin.keys)[0]
            let origin = Origin(name: key,
                                url: dictOrigin[key] ?? "")
            
            let dictLocation = result.location
            let locationKey = Array(dictLocation.keys)[0]
            let location = CharacterLocation(name: locationKey,
                                             url: dictLocation[locationKey] ?? "")
            
            charactersModels.append(Character(id: Int(result.id),
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
        if !charactersModels.isEmpty {
            output?.didLoad(with: charactersModels, loadType: page == GlobalConstants.initialPage ? .reload : .nextPage, count: Int(infoTable?.characterCount ?? 0), isOffline: true)
            
            if page == Int(infoTable?.characterPages ?? 0) {
                page = Int(infoTable?.characterPages ?? 0)
            } else {
                page += 1
            }
            params.page = String(page)
        } else {
            output?.didError(with: NetworkErrors.dataIsEmpty)
        }
    }
    
    func loadOfflineWithParams() {
        var resultsByParams: [CharacterFilterCDModel] = []
        var resultsByParamCount = 0
        var wasSearch = false
        if params.name == nil, let paramsGender = params.gender, let paramsStatus = params.status {
            if paramsGender.isEmpty, paramsStatus.isEmpty {
                loadOffline()
                return
            } else {
                resultsByParams = persistentProvider.fetchCharactersFilterModels(with: params, and: page)
                resultsByParamCount = persistentProvider.fetchCharactersFilterModels(with: params).count
            }
        }  else if params.name == nil, params.gender == nil, params.status == nil  {
            loadOffline()
            return
        } else if params.name == "", params.gender != nil, params.status != nil {
            resultsByParams = persistentProvider.fetchCharactersFilterModels(with: params, and: page)
            resultsByParamCount = persistentProvider.fetchCharactersFilterModels(with: params).count
        } else if let _ = params.name {
            resultsByParams = persistentProvider.fetchCharactersFilterModels(with: params, and: 0)
            resultsByParamCount = resultsByParams.count
            wasSearch = true
        } else {
            resultsByParams = persistentProvider.fetchCharactersFilterModels(with: params, and: page)
            resultsByParamCount = persistentProvider.fetchCharactersFilterModels(with: params).count
        }
        
        if resultsByParams.isEmpty {
            output?.didError(with: NetworkErrors.dataIsEmpty)
        } else {
            var charactersModels: [Character] = []
            for result in resultsByParams {
                let dictOrigin = result.origin
                let key = Array(dictOrigin.keys)[0]
                let origin = Origin(name: key,
                                    url: dictOrigin[key] ?? "")
                
                let dictLocation = result.location
                let locationKey = Array(dictLocation.keys)[0]
                let location = CharacterLocation(name: locationKey,
                                                 url: dictLocation[locationKey] ?? "")
                
                charactersModels.append(Character(id: Int(result.id),
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
            if !wasSearch {
                var newPageCount = 0
                if resultsByParamCount > 20 {
                    let ostatok = (resultsByParamCount % 20) == 0 ? 0 : 1
                    newPageCount = Int(Double(resultsByParamCount) / 20) + ostatok
                } else {
                    newPageCount = 1
                }
                
                if page == newPageCount {
                    page = newPageCount
                } else {
                    page += 1
                }
                params.page = String(page)
            }
            output?.didLoad(with: charactersModels, loadType: page == GlobalConstants.initialPage ? .reload : .nextPage, count: resultsByParamCount, isOffline: true)
        }
    }
}
