//
//  SyslogLoggerFormatter.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 25/03/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

/// standard: https://tools.ietf.org/html/rfc5424
public final class SyslogLoggerFormatter: LoggerFormatter {
    public struct Configuration {
        let appName: String
    }

    private let dateFormatter: DateTimeFormatter
    private let timestampService: TimestampService

    public init(dateFormatter: DateTimeFormatter, timestampService: TimestampService) {
        self.dateFormatter = dateFormatter
        self.timestampService = timestampService
    }

    public func format(_ level: LogLevel, domain: Domain, message: String, file: String, function: String) -> String {
        let logOrigin = "\(filename(from: file)).\(function)"
        let date = dateFormatter.format(timestamp: timestampService.getTimestamp(), format: .iso8601)
        let priority = makePriority(from: level)
        return String(format: "<%@>1 %@ CleanCore %@ - - BOM%@", priority, date, logOrigin, message)
    }

    public func formatStartInterval(id: LoggerId, domain: Domain, message: String, file: String, function: String) -> String {
        let message = "#\(id)\tStart: \(message)"
        return format(.info, domain: domain, message: message, file: file, function: function)
    }

    public func formatEndInterval(id: LoggerId, domain: Domain, message: String, file: String, function: String) -> String {
        let message = "#\(id)\tEnd: \(message)"
        return format(.info, domain: domain, message: message, file: file, function: function)
    }

    private func filename(from path: String) -> String {
        return path.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? path
    }

    private func makePriority(from level: LogLevel) -> String {
        switch level {
        case .error:
            return "2"
        case .warning:
            return "4"
        case .info:
            return "6"
        case .debug:
            return "7"
        }
    }
}
