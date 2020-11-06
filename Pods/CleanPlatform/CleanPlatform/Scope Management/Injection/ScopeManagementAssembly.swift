//
//  ScopeManagementAssembly.swift
//  CleanPlatform
//
//  Created by Ondrej Fabian on 30/10/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

public final class ScopeManagementAssembly: Assembly {

    public func assemble(container: Container) {

        container.register(ApplicationScope.self) { _ in
            ApplicationScope()
        }.inObjectScope(.container)

        container.register(ScopeController.self) { r in
            let applicationScope = r.resolve(ApplicationScope.self)!
            let scopeService = r.resolve(ScopeService.self)!
            return ScopeControllerImpl(applicationScope: applicationScope, scopeService: scopeService)
        }.inObjectScope(.container)
    }
}
