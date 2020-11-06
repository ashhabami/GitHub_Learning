//
//  ErrorCommonAssembly.swift
//  CleanCore
//
//  Created by Ondrej Fabian on 15/12/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

public final class ErrorCommonAssembly: Assembly {

    public static let defaultErrorConverterResolverName = "defaultErrorConvertor"

    public func assemble(container: Container) {

        container.register(ErrorHandlingPolicy.self) { r in
            return HandleAllErrorsPolicy()
        }

        container.register(DisplayableErrorConvertor.self, name: ErrorCommonAssembly.defaultErrorConverterResolverName) { r in
            return DefaultErrorConvertor()
        }

        container.register(ErrorController.self) { r in
            return ErrorControllerImpl()
        }.inObjectScope(.container)
    }
}
