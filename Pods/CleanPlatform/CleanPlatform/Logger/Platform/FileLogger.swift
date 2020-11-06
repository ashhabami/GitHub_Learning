//
//  FileLogger.swift
//  AppConfiguration
//
//  Created by Kryštof Matěj on 01/12/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

import CleanCore
import Foundation

public final class FileLogger: Logger {
    private let formatter: LoggerFormatter
    private var intervals = [LoggerId: Domain]()

    public init(formatter: LoggerFormatter) {
        self.formatter = formatter
    }

    public func log(_ level: LogLevel, domain: Domain, message: String, file: String, function: String) {
        let message = formatter.format(level, domain: domain, message: message, file: file, function: function)
        logToFile(message)
    }

    public func logIntervalStart(id: LoggerId, domain: Domain, message: String, file: String, function: String) {
        intervals[id] = domain
        let message = formatter.formatStartInterval(id: id, domain: domain, message: message, file: file, function: function)
        logToFile(message)
    }

    public func logIntervalEnd(id: LoggerId, message: String, file: String, function: String) {
        let domain = intervals[id] ?? .default
        let message = formatter.formatEndInterval(id: id, domain: domain, message: message, file: file, function: function)
        logToFile(message)
        intervals[id] = nil
    }

    private func logToFile(_ message: String) {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }

        let fileURL = dir.appendingPathComponent("app.log")
        var content = (try? String(contentsOf: fileURL, encoding: .utf8)) ?? ""
        content += message + "\n"
        _ = try? content.write(to: fileURL, atomically: false, encoding: .utf8)
    }
}
