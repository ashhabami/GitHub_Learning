//
//  ScopeContainer.swift
//  CleanPlatform
//
//  Created by Ondrej Fabian on 30/10/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import CleanCore
import Swinject

enum ScopeContainerError: Error {
    case serviceNotRegistered
    case containerMissing
}

class ScopeContainer {

    let assembler: Assembler

    init?(scope: Scope, scopeSpec: ScopeSpec, parent: ScopeContainer, startData: Any) {
        assembler = Assembler(parentAssembler: parent.assembler)
        do {
            let assembly = try scopeSpec.start(startData)
            let instanceProviderAssembly = makeInstanceProviderAssembly(scope: scope)
            applyAssemblies([assembly, instanceProviderAssembly] + scopeSpec.assemblies())
        } catch {
            logDebug(error, domain: .scope)
        }
    }

    init(scope: Scope, scopeSpec: ScopeSpec, parent: ScopeContainer? = nil) {
        assembler = Assembler(parentAssembler: parent?.assembler)
        applyAssemblies([makeInstanceProviderAssembly(scope: scope)] + scopeSpec.assemblies())
    }

    init(scope: Scope, assembler: Assembler) {
        self.assembler = assembler
        applyAssemblies([makeInstanceProviderAssembly(scope: scope)])
    }

    private func makeInstanceProviderAssembly(scope: Scope) -> Assembly {
        return InstanceProviderAssembly(scopeContainer: self, scope: scope)
    }

    private func applyAssemblies(_ assemblies: [Assembly]) {
        assembler.apply(assemblies: assemblies)
    }

    func getInstance<T>(_ type: T.Type) throws -> T {
        return try synchronizeThrowing {
            let resolvedService = try self.assembler.resolver.resolve(type) ?! ScopeContainerError.serviceNotRegistered
            return resolvedService
        }
    }

    func getInstance<T, A>(_ type: T.Type, argument: A) throws -> T {
        return try synchronizeThrowing {
            let resolvedService = try self.assembler.resolver.resolve(type, argument: argument) ?! ScopeContainerError.serviceNotRegistered
            return resolvedService
        }
    }
}
