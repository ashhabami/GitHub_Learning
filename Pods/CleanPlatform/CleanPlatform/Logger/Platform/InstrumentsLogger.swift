//
//  InstrumentsLogger.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 29/10/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

import os
import os.signpost
import CleanCore

@available(OSX 10.14, iOS 12.0, watchOS 5.0, tvOS 12.0, *)
public final class InstrumentsLogger: Logger {
    
    public init() {}

    public func log(_ level: LogLevel, domain: Domain, message: String, file _: String, function _: String) {
        let log = OSLog(subsystem: "com.cleverlance.clean-platform", category: "event")
        let logType = getLogType(for: level)
        os_log(logType, log: log, "DOMAIN:%{public}@,MESSAGE:%{public}@", domain.text, message)
    }

    private func getLogType(for level: LogLevel) -> OSLogType {
        switch level {
        case .error:
            return .fault
        case .warning:
            return .error
        case .info:
            return .info
        case .debug:
            return .debug
        }
    }

    public func logIntervalStart(id: LoggerId, domain: Domain, message: String, file: String, function: String) {
        let log = OSLog(subsystem: "com.cleverlance.clean-platform", category: "interval")
        let signpostId = OSSignpostID(log: log, object: id as AnyObject)
        os_signpost(.begin, log: log, name: "default", signpostID: signpostId, "START DOMAIN:%{public}@,MESSAGE:%{public}@",  domain.text, message)
    }

    public func logIntervalEnd(id: LoggerId, message: String, file: String, function: String) {
        let log = OSLog(subsystem: "com.cleverlance.clean-platform", category: "interval")
        let signpostId = OSSignpostID(log: log, object: id as AnyObject)
        os_signpost(.end, log: log, name: "default", signpostID: signpostId, "END MESSAGE:%{public}@", message)
    }
}
