//
//  LoggerFormatter.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 25/03/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

public protocol LoggerFormatter {
    func format(_ level: LogLevel, domain: Domain, message: String, file: String, function: String) -> String
    func formatStartInterval(id: LoggerId, domain: Domain, message: String, file: String, function: String) -> String
    func formatEndInterval(id: LoggerId, domain: Domain, message: String, file: String, function: String) -> String
}
