//
//  ScopeServiceImpl.swift
//  Cleancore
//
//  Created by Ondrej Fabian on 27/10/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import Foundation
import Swinject
import CleanCore

public class ScopeServiceImpl: ScopeService, ScopedInstanceProvider {

    let scopeSpecProvider: ScopeSpecProvider

    var scopeContainers: [Scope: ScopeContainer]

    init(rootScope: Scope, scopeSpecProvider: ScopeSpecProvider, rootScopeContainer: ScopeContainer) {
        self.scopeSpecProvider = scopeSpecProvider
        scopeContainers = [rootScope: rootScopeContainer]
    }

    public func start(scope: Scope, with data: Any, parent: Scope) throws {
        let spec = try scopeSpecProvider.spec(describing: scope) ?! ScopeServiceError.missingScopeSpec
        let parentContainer = try scopeContainers[parent] ?! ScopeServiceError.parentNotFound
        let container = try ScopeContainer(scope: scope, scopeSpec: spec, parent: parentContainer, startData: data) ?! ScopeServiceError.incorrectStartData
        scopeContainers[scope] = container
    }

    public func discard(scope: Scope) {
        scopeContainers[scope] = nil
    }

    public func getInstance<T>(_ type: T.Type, scope: Scope) throws -> T {
        let container = try scopeContainers[scope] ?! ScopeContainerError.serviceNotRegistered
        return try container.getInstance(type)
    }

    public func getInstance<T, A>(_ type: T.Type, scope: Scope, argument: A) throws -> T {
        let container = try scopeContainers[scope] ?! ScopeContainerError.serviceNotRegistered
        return try container.getInstance(type, argument: argument)
    }
}
