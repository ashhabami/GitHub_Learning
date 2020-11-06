//
//  LocalizerAssembly.swift
//  CleanPlatform
//
//  Created by Ondrej Fabian on 01/11/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

final class LocalizerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(Localizer.self) { r in
            FoundationLocalizer()
        }
    }

    func loaded(resolver: Resolver) {
        setStaticLocalizer(resolver.resolve(Localizer.self)!)
    }
}
