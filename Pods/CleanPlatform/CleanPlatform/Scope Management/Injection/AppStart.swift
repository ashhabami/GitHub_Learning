//
//  AppStart.swift
//  CleanPlatform
//
//  Created by Ondrej Fabian on 31/10/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

public func startAppByResolvingType<Type>(scopeSpecProvider: ScopeSpecProvider) throws -> Type {
    let rootAssembly = RootAssembly(scopeSpecProvider: scopeSpecProvider)
    let scopeManagementAssembly = ScopeManagementAssembly()
    let assebler = Assembler([rootAssembly, scopeManagementAssembly])
    let scopeService = assebler.resolver.resolve(ScopeServiceImpl.self)!
    let applicationScope = assebler.resolver.resolve(ApplicationScope.self)!
    return try scopeService.getInstance(Type.self, scope: applicationScope)
}
