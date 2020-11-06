//
//  DebouncerAssembly.swift
//  CleanCore
//
//  Created by Ondrej Fabian on 16/01/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

final class DebouncerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(Debouncer.self) { r in
            let eventTimer = r.resolve(EventTimer.self)!
            return DebouncerImpl(eventTimer: eventTimer)
        }
    }
}
