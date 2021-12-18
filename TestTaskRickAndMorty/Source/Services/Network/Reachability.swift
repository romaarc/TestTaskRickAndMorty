//
//  Reachability.swift
//  TestTaskRickAndMorty
//
//  Created by Roman Gorshkov on 04.12.2021.
//

import Foundation
import Network
import SystemConfiguration
import UIKit.UIDevice

protocol ReachabilityProtocol {
    var isReachable: Bool { get }
    func isConnectedToNetwork() -> Bool
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
    
    func isConnectedToNetwork() -> Bool {
        if UIDevice.current.isSimulator {
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
            if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
                return false
            }
            
            let isReachable = flags == .reachable
            let needsConnection = flags == .connectionRequired
            
            return isReachable && !needsConnection
        } else {
            return self.isReachable
        }
    }
}
