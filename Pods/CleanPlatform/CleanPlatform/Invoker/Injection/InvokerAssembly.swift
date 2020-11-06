//
//  InvokerAssembly.swift
//  FMC
//
//  Created by Ondrej Fabian on 24/05/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

final class InvokerAssembly: Assembly {

    func assemble(container: Container) {

        container.register(ErrorHandler.self) { _ in
            DefaultErrorHandler()
        }

        container.register(Executor.self) { r in
            BackgroundExecutor()
        }

        container.register(InvokerConfiguration.self) { _ in
            DefaultInvokerConfiguration()
        }

        container.register(Invoker.self) { r in
            let executor = r.resolve(Executor.self)!
            let activityController = r.resolve(ActivityController.self)!
            let configuration = r.resolve(InvokerConfiguration.self)!
            return InvokerImpl(executor: executor, activityController: activityController, configuration: configuration)
        }.inObjectScope(.container).initCompleted { r, invoker in
            if let invoker = invoker as? InvokerImpl {
                invoker.errorHandler = r.resolve(ErrorHandler.self)!
            }
        }
    }
}

public final class AuthenticatedInvokerAssembly: Assembly {

    public init() {}

    public func assemble(container: Container) {

        container.register(Invoker.self) { r in
            let executor = r.resolve(Executor.self)!
            let activityController = r.resolve(ActivityController.self)!
            let configuration = r.resolve(InvokerConfiguration.self)!
            return InvokerImpl(executor: executor, activityController: activityController, configuration: configuration)
        }.inObjectScope(.container).initCompleted { r, invoker in
            if let invoker = invoker as? InvokerImpl {
                invoker.errorHandler = r.resolve(ErrorHandler.self)!
            }
        }
    }
}
