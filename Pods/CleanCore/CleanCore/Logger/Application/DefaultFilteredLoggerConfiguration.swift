//
//  DefaultFilteredLoggerConfiguration.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 15/08/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

public protocol FilteredLoggerConfiguration {
    func getDomainsHiddenFromLogging() -> [Domain]
    func getMaximumLoggedLogLevel() -> LogLevel
}

public final class DefaultFilteredLoggerConfiguration: FilteredLoggerConfiguration {

    public init() {}

    public func getDomainsHiddenFromLogging() -> [Domain] {
        return []
    }

    public func getMaximumLoggedLogLevel() -> LogLevel {
        return .debug
    }
}
