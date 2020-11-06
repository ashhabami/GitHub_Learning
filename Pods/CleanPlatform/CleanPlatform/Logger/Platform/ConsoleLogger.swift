//
//  ConsoleLogger.swift
//  Babylon
//
//  Created by Ondrej Fabian on 22/11/2015.
//  Copyright © 2015 Cleverlance. All rights reserved.
//

import CleanCore
import Foundation

open class ConsoleLogger: Logger {

    private let formatter: LoggerFormatter
    private var intervals = [LoggerId: Domain]()
    
    public init(formatter: LoggerFormatter) {
        self.formatter = formatter
    }

    open func log(_ level: LogLevel, domain: Domain, message: String, file: String, function: String) {
        let message = formatter.format(level, domain: domain, message: message, file: file, function: function)
        NSLog(message)
    }

    private func filename(from path: String) -> String {
        return path.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? path
    }

    public func logIntervalStart(id: LoggerId, domain: Domain, message: String, file: String, function: String) {
        intervals[id] = domain
        let message = formatter.formatStartInterval(id: id, domain: domain, message: message, file: file, function: function)
        NSLog(message)
    }

    public func logIntervalEnd(id: LoggerId, message: String, file: String, function: String) {
        let domain = intervals[id] ?? .default
        let message = formatter.formatEndInterval(id: id, domain: domain, message: message, file: file, function: function)
        NSLog(message)
        intervals[id] = nil
    }
}
