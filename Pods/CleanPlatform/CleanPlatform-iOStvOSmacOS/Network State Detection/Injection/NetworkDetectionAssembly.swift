//
//  NetworkDetectionAssembly.swift
//  FMC
//
//  Created by Ondrej Fabian on 21/02/2017.
//  Copyright (c) 2017 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

final class NetworkDetectionAssembly: Assembly {

    func assemble(container: Container) {
        container.register(NetworkStateNotifier.self) { _ in
            NetworkStateNotifierImpl()
        }

        container.register(NetworkStateController.self) { r in
            let networkStateNotifier = r.resolve(NetworkStateNotifier.self)!
            return NetworkStateControllerImpl(networkStateNotifier: networkStateNotifier)
        }.inObjectScope(.container)
    }
}
