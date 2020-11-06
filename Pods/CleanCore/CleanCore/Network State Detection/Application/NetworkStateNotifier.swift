//
//  NetworkStateNotifier.swift
//  FMC
//
//  Created by Ondrej Fabian on 21/02/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

public typealias NetworkReachableSubscription = ValueBlock<NetworkState>

public protocol NetworkStateNotifier {
    func getCurrentState() -> NetworkState
    func subscribeToNetworkStateUpdates(_ update: @escaping NetworkReachableSubscription)
}
