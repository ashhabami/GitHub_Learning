//
//  InstanceProviderImpl.swift
//  CleanCore
//
//  Created by Ondrej Fabian on 28/08/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

import CleanCore

public class InstanceProviderImpl: InstanceProvider {

    private weak var scopeContainer: ScopeContainer?

    init(scopeContainer: ScopeContainer) {
        self.scopeContainer = scopeContainer
    }

    public func getInstance<T>(_ type: T.Type) throws -> T {
        guard let container = self.scopeContainer else {
            logError("Resolving type: \(type) from absent container! Possibly deallocated.")
            throw ScopeContainerError.containerMissing
        }
        return try container.getInstance(type)
    }

    public func getInstance<T, A>(_ type: T.Type, argument: A) throws -> T {
        guard let container = self.scopeContainer else {
            logError("Resolving type: \(type) from absent container! Possibly deallocated.")
            throw ScopeContainerError.containerMissing
        }
        return try container.getInstance(type, argument: argument)
    }
}
