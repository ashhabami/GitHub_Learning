//
//  InstanceProviderAssembly.swift
//  CleanPlatform
//
//  Created by Ondrej Fabian on 30/10/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import CleanCore
import Swinject

public final class InstanceProviderAssembly: Assembly {

    private weak var scopeContainer: ScopeContainer?
    private weak var scope: Scope?

    init(scopeContainer: ScopeContainer, scope: Scope) {
        self.scopeContainer = scopeContainer
        self.scope = scope
    }

    public func assemble(container: Container) {
        container.register(InstanceProvider.self) { _ in
            return InstanceProviderImpl(scopeContainer: self.scopeContainer!)
        }

        container.register(ScopedInstanceProvider.self) { r in
            r.resolve(ScopeServiceImpl.self)!
        }

        container.register(Scope.self) { _ in
            self.scope!
        }
    }
}
