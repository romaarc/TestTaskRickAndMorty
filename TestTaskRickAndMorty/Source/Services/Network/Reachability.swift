//
//  Reachability.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 04.12.2021.
//

import Foundation
import Network

protocol ReachabilityProtocol {
    var isReachable: Bool { get }
}

final class Reachability: ReachabilityProtocol {
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue
    private(set) var isReachable: Bool
   
    init() {
        queue = DispatchQueue(label: "Monitor Reachability")
        monitor = NWPathMonitor()
        isReachable = false
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isReachable = path.status == .satisfied ? true : false
        }
        monitor.start(queue: queue)
    }
}
