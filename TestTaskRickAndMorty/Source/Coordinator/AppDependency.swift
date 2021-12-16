//
//  AppDependency.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 04.12.2021.
//

import Foundation

protocol HasNetworkService {
    var rickAndMortyNetworkService: NetworkServiceProtocol { get }
    var reachabilityService: ReachabilityProtocol { get }
}

class AppDependency {
    let networkService: NetworkService
    let reachability: ReachabilityProtocol

    init(networkService: NetworkService, reachability: ReachabilityProtocol) {
        self.networkService = networkService
        self.reachability = reachability
    }

    static func makeDefault() -> AppDependency {
        let reachability = Reachability()
        let networkService = NetworkService(customDecoder: JSONDecoderCustom())
        return AppDependency(networkService: networkService, reachability: reachability)
    }
}

extension AppDependency: HasNetworkService {
    var rickAndMortyNetworkService: NetworkServiceProtocol {
        return self.networkService
    }
    var reachabilityService: ReachabilityProtocol {
        return self.reachability
    }
}
