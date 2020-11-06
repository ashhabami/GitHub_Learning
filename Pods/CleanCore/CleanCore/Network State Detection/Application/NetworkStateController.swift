//
//  NetworkStateController.swift
//  FMC
//
//  Created by Ondrej Fabian on 21/02/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

public enum NetworkState {
    case unreachable
    case reachableWiFi
    case reachableWWAN
}

public protocol NetworkStateController: BaseController {
    func getNetworkState() -> NetworkState
}

public class NetworkStateControllerImpl: BaseControllerImpl, NetworkStateController {

    private let networkStateNotifier: NetworkStateNotifier

    public init(networkStateNotifier: NetworkStateNotifier) {
        self.networkStateNotifier = networkStateNotifier
        super.init()
        networkStateNotifier.subscribeToNetworkStateUpdates { [weak self] _ in
            self?.notifyListenersAboutUpdate()
        }
    }

    public func getNetworkState() -> NetworkState {
        return networkStateNotifier.getCurrentState()
    }
}
