//
//  GenericConfigurationAssembly.swift
//  CleanPlatform
//
//  Created by Ondrej Fabian on 01/11/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

open class GenericConfigurationAssembly: Assembly {

    open func assemble(container: Container) {

        container.register(GenericConfiguration.self) { _ in
            DefaultGenericConfiguration()
        }
    }
}

