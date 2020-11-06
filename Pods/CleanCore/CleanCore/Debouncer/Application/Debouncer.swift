//
//  Debouncer.swift
//  CleanCore
//
//  Created by Ondrej Fabian on 16/01/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import Foundation

public protocol Debouncer {
    func debounce(delay: Miliseconds, call: @escaping Block)
}

public class DebouncerImpl: Debouncer {

    let eventTimer: EventTimer
    var debouncedCall: Block = { }

    public init(eventTimer: EventTimer) {
        self.eventTimer = eventTimer
    }

    public func debounce(delay: Miliseconds, call: @escaping Block) {
        eventTimer.stop()
        self.debouncedCall = call
        eventTimer.fireOnce(delay) { [weak self] in
            self?.debouncedCall()
        }
    }
}
