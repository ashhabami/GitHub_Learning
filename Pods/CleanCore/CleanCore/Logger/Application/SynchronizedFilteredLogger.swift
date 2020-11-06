//
//  SynchronizedFilteredLogger.swift
//  CleanCore
//
//  Created by Jan Halousek on 22/11/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

public final class SynchronizedFilteredLogger: FilteredLogger {
    private let logger: FilteredLogger

    public init(logger: FilteredLogger) {
        self.logger = logger
    }

    public func log(_ level: LogLevel, domain: Domain, message: String, file: String, function: String) {
        synchronize {
            self.logger.log(level, domain: domain, message: message, file: file, function: function)
        }
    }

    public func logIntervalStart(id: LoggerId, domain: Domain, message: String, file: String, function: String) {
        return synchronize {
            self.logger.logIntervalStart(id: id, domain: domain, message: message, file: file, function: function)
        }
    }

    public func logIntervalEnd(id: LoggerId, message: String, file: String, function: String) {
        return synchronize {
            self.logger.logIntervalEnd(id: id, message: message, file: file, function: function)
        }
    }
}
