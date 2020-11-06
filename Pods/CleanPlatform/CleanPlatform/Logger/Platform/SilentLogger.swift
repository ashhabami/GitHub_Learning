//
//  SilentLogger.swift
//  FMC
//
//  Created by Ondrej Fabian on 15/03/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import CleanCore

public class SilentLogger: Logger {

    public init() { }

    public func log(_ level: LogLevel, domain: Domain, message: String, file: String, function: String) {
    }

    public func logIntervalStart(id: LoggerId, domain: Domain, message: String, file: String, function: String) {
    }
    
    public func logIntervalEnd(id: LoggerId, message: String, file: String, function: String) {
    }
}
