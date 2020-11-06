//
//  RootAssembly.swift
//  CleanPlatform
//
//  Created by Ondrej Fabian on 31/10/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

public final class RootAssembly: Assembly {

    let scopeSpecProvider: ScopeSpecProvider

    public init(scopeSpecProvider: ScopeSpecProvider) {
        self.scopeSpecProvider = scopeSpecProvider
    }

    public func assemble(container: Container) {

        container.register(ScopeService.self) { r in
            return r.resolve(ScopeServiceImpl.self)!
        }

        container.register(RootScope.self) { _ in
            return RootScope()
        }.inObjectScope(.container)

        container.register(ScopeContainer.self, name: "Root") { r in
            let scope = r.resolve(RootScope.self)!
            return ScopeContainer(scope: scope, assembler: Assembler(container: container))
        }

        container.register(ScopeServiceImpl.self) { r in
            let scope = r.resolve(RootScope.self)!
            let rootScopeContainer = r.resolve(ScopeContainer.self, name: "Root")!
            return ScopeServiceImpl(rootScope: scope, scopeSpecProvider: self.scopeSpecProvider, rootScopeContainer: rootScopeContainer)
        }.inObjectScope(.container)
    }

    public func loaded(resolver: Resolver) {
        let scopeService = resolver.resolve(ScopeService.self)!
        do {
            let rootScope = resolver.resolve(RootScope.self)!
            let applicationScope = resolver.resolve(ApplicationScope.self)!
            try scopeService.start(scope: applicationScope, with: [] as AnyObject, parent: rootScope)
        } catch {
            logError(error, domain: .scope)
        }
    }
}
