//
//  StaticLogging.swift
//  FMC
//
//  Created by Ondrej Fabian on 20/07/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public func logError(_ error: Error, domain: Domain = .default, file: String = #file, function: String = #function) {
    LoggerHolder.logger.log(.error, domain: domain, message: "\(error)", file: file, function: function)
}

public func logError(_ message: String, domain: Domain = .default, file: String = #file, function: String = #function) {
    LoggerHolder.logger.log(.error, domain: domain, message: message, file: file, function: function)
}

public func logWarning(_ error: Error, domain: Domain = .default, file: String = #file, function: String = #function) {
    LoggerHolder.logger.log(.warning, domain: domain, message: "\(error)", file: file, function: function)
}

public func logWarning(_ message: String, domain: Domain = .default, file: String = #file, function: String = #function) {
    LoggerHolder.logger.log(.warning, domain: domain, message: message, file: file, function: function)
}

public func logInfo(_ error: Error, domain: Domain = .default, file: String = #file, function: String = #function) {
    LoggerHolder.logger.log(.info, domain: domain, message: "\(error)", file: file, function: function)
}

public func logInfo(_ message: String, domain: Domain = .default, file: String = #file, function: String = #function) {
    LoggerHolder.logger.log(.info, domain: domain, message: message, file: file, function: function)
}

public func logDebug(_ error: Error, domain: Domain = .default, file: String = #file, function: String = #function) {
    LoggerHolder.logger.log(.debug, domain: domain, message: "\(error)", file: file, function: function)
}

public func logDebug(_ message: String, domain: Domain = .default, file: String = #file, function: String = #function) {
    LoggerHolder.logger.log(.debug, domain: domain, message: message, file: file, function: function)
}

public func logIntervalStart(_ message: String, domain: Domain, file: String = #file, function: String = #function) -> LoggerId {
    let id = LoggerHolder.loggerIdResolver.getId()
    LoggerHolder.logger.logIntervalStart(id: id, domain: domain, message: message, file: file, function: function)
    return id
}

public func logIntervalStart(_ message: String, domain: Domain, object: AnyObject, file: String = #file, function: String = #function) {
    let id = LoggerHolder.loggerIdResolver.getId(for: object)
    LoggerHolder.logger.logIntervalStart(id: id, domain: domain, message: message, file: file, function: function)
}

public func logIntervalEnd(_ message: String, id: LoggerId, file: String = #file, function: String = #function) {
    LoggerHolder.logger.logIntervalEnd(id: id, message: message, file: file, function: function)
}

public func logIntervalEnd(_ message: String, object: AnyObject, file: String = #file, function: String = #function) {
    let id = LoggerHolder.loggerIdResolver.getId(for: object)
    LoggerHolder.logger.logIntervalEnd(id: id, message: message, file: file, function: function)
}

public func setStaticLogger(_ logger: Logger?, loggerIdResolver: LoggerIdResolver?) {
    LoggerHolder.logger = logger!
    LoggerHolder.loggerIdResolver = loggerIdResolver!
}

public class LoggerHolder {
    public static var logger: Logger!
    public static var loggerIdResolver: LoggerIdResolver!
}
