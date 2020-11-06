//
//  LocalStorageFactoryAssembly.swift
//  CleanCore
//
//  Created by Jan Halousek on 05/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import CleanCore
import Swinject

public final class LocalStorageFactoryAssembly: Assembly {

    public init() {}

    public func assemble(container: Container) {
        container.register(LocalStorageFactory.self) { r in
            return LocalStorageFactoryImpl()
        }
    }
}
