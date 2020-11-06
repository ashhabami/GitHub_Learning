//
//  SynchronizerAssembly.swift
//  CleanPlatform
//
//  Created by Ondrej Fabian on 03/11/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

final class SynchronizerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(Synchronizer.self) { _ in
            return SynchronizerImpl()
        }.inObjectScope(.container)
    }

    func loaded(resolver: Resolver) {
        setStaticSynchronizer(resolver.resolve(Synchronizer.self)!)
    }
}
