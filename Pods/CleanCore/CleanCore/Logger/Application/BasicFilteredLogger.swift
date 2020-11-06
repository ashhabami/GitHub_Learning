//
//  BasicFilteredLogger.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 10/08/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

public final class BasicFilteredLogger: FilteredLogger {
    private let logger: Logger
    private let configuration: FilteredLoggerConfiguration
    private var intervals = [Int: Domain]()

    public init(logger: Logger, configuration: FilteredLoggerConfiguration) {
        self.logger = logger
        self.configuration = configuration
    }

    public func log(_ level: LogLevel, domain: Domain, message: String, file: String, function: String) {
        guard isDomainLogged(domain) else {
            return
        }

        guard isLogLevelLogged(level) else {
            return
        }

        logger.log(level, domain: domain, message: message, file: file, function: function)
    }

    private func isDomainLogged(_ domain: Domain) -> Bool {
        return !configuration.getDomainsHiddenFromLogging().contains(domain)
    }

    private func isLogLevelLogged(_ logLevel: LogLevel) -> Bool {
        let logLevels = getLogLevels(for: configuration.getMaximumLoggedLogLevel())
        return logLevels.contains(logLevel)
    }

    private func getLogLevels(for maximumLogLevel: LogLevel) -> [LogLevel] {
        switch maximumLogLevel {
        case .error:
            return [.error]
        case .warning:
            return [.error, .warning]
        case .info:
            return [.error, .warning, .info]
        case .debug:
            return [.error, .warning, .info, .debug]
        }
    }

    public func logIntervalStart(id: LoggerId, domain: Domain, message: String, file: String, function: String) {
        guard isDomainLogged(domain) else {
            return
        }

        guard isLogLevelLogged(.info) else {
            return
        }

        logger.logIntervalStart(id: id, domain: domain, message: message, file: file, function: function)
        intervals[id] = domain
    }

    public func logIntervalEnd(id: LoggerId, message: String, file: String, function: String) {
        guard intervals[id] != nil else {
            return
        }
        
        logger.logIntervalEnd(id: id, message: message, file: file, function: function)
        intervals[id] = nil
    }
}
