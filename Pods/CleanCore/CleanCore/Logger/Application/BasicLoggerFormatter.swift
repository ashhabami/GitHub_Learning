//
//  BasicLoggerFormatter.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 25/03/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

public final class BasicLoggerFormatter: LoggerFormatter {
    public init() {}

    public func format(_ level: LogLevel, domain: Domain, message: String, file: String, function: String) -> String {
        let logOrigin = "\(filename(from: file)).\(function)"
        return String(format: "%@ %@ %@", level.getPrefix(), logOrigin, message)
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
}
