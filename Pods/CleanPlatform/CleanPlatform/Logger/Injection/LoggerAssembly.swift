//
//  LoggerAssembly.swift
//  FMC
//
//  Created by Ondrej Fabian on 24/05/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import CleanCore
import Swinject

final class LoggerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(Logger.self) { r in
            let formatter = r.resolve(LoggerFormatter.self)!
            return ConsoleLogger(formatter: formatter)
        }

        container.register(LoggerFormatter.self) { _ in
            BasicLoggerFormatter()
        }

        container.register(FilteredLogger.self) { r in
            r.resolve(SynchronizedFilteredLogger.self)!
        }

        container.register(BasicFilteredLogger.self) { r in
            let logger = r.resolve(Logger.self)!
            let configuration = r.resolve(FilteredLoggerConfiguration.self)!
            return BasicFilteredLogger(logger: logger, configuration: configuration)
        }

        container.register(SynchronizedFilteredLogger.self) { r in
            let logger = r.resolve(BasicFilteredLogger.self)!
            return SynchronizedFilteredLogger(logger: logger)
        }

        container.register(FilteredLoggerConfiguration.self) { _ in
            DefaultFilteredLoggerConfiguration()
        }
        
        container.register(LoggerIdResolver.self) { _ in
            LoggerIdResolverImpl()
        }
    }

    func loaded(resolver: Resolver) {
        let logger = resolver.resolve(FilteredLogger.self)!
        let loggerIdResolver = resolver.resolve(LoggerIdResolver.self)!
        setStaticLogger(logger, loggerIdResolver: loggerIdResolver)
    }
}
