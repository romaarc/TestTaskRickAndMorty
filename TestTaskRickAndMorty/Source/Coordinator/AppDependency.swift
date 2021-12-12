//
//  AppDependency.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 04.12.2021.
//

import Foundation

typealias ModuleDependencies = HasNetworkService

protocol HasNetworkService {
    var rickAndMortyNetworkService: NetworkServiceProtocol { get }
}

class AppDependency {
    let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    static func makeDefault() -> AppDependency {
        let networkService = NetworkService(reachability: Reachability(),
                                            customDecoder: JSONDecoderCustom())
        return AppDependency(networkService: networkService)
    }
}

extension AppDependency: HasNetworkService {
    var rickAndMortyNetworkService: NetworkServiceProtocol {
        return self.networkService
    }
}
