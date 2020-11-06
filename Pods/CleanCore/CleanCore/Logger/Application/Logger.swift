//
//  Logger.swift
//  Babylon
//
//  Created by Ondrej Fabian on 22/11/2015.
//  Copyright © 2015 Cleverlance. All rights reserved.
//

public enum LogLevel {
    case error
    case warning
    case info
    case debug

    public func getPrefix() -> String {
        switch self {
        case .error:
            return "‼️‼️‼️ERROR:"
        case .warning:
            return "⚠️⚠️⚠️WARNING:"
        case .info:
            return "ℹ️ℹ️ℹ️INFO:"
        case .debug:
            return "⚙⚙⚙DEBUG:"
        }
    }
}

public typealias LoggerId = Int

public protocol Logger {
    func log(_ level: LogLevel, domain: Domain, message: String, file: String, function: String)
    func logIntervalStart(id: LoggerId, domain: Domain, message: String, file: String, function: String)
    func logIntervalEnd(id: LoggerId, message: String, file: String, function: String)
}

public protocol FilteredLogger: Logger {}
