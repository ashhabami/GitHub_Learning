//
//  NetworkStateNotifierImpl.swift
//  FMC
//
//  Created by Ondrej Fabian on 21/02/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import CleanCore
import Reachability
import Foundation

public class NetworkStateNotifierImpl: NetworkStateNotifier {

    let reachability = Reachability()!

    var networkReachableSubscription: NetworkReachableSubscription?

    public init() {
        reachability.whenReachable = updateReachability
        reachability.whenUnreachable = updateReachability
    }

    public func updateReachability(reachability: Reachability) {
        DispatchQueue.main.async {
            let state = self.getCurrentState(from: reachability)
            self.networkReachableSubscription?(state)
        }
    }

    public func getCurrentState() -> NetworkState {
        return getCurrentState(from: reachability)
    }

    private func getCurrentState(from reachability: Reachability) -> NetworkState {
        switch reachability.connection {
        case .cellular:
            return .reachableWWAN
        case .wifi:
            return .reachableWiFi
        case .none:
            return .unreachable
        }
    }

    public func subscribeToNetworkStateUpdates(_ update: @escaping NetworkReachableSubscription) {
        self.networkReachableSubscription = update
        do {
            try reachability.startNotifier()
        } catch {
            logWarning(error)
        }
    }
}
