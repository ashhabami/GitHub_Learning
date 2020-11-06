//
//  TimerAssembly.swift
//  FMC
//
//  Created by Libor Huspenina on 30/08/2016.
//  Copyright (c) 2016 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

final class TimerAssembly: Assembly {

    func assemble(container: Container) {

        container.register(EventTimer.self) { _ in
            EventTimerImpl()
        }.inObjectScope(.transient)

        container.register(EventTimerConfiguration.self) { _ in
            return EventTimerConfigurationImpl()
        }

        container.register(EventTimerController.self) { r in
            let eventTimer = r.resolve(EventTimer.self)!
            let eventTimerConfig = r.resolve(EventTimerConfiguration.self)!
            return EventTimerControllerImpl(eventTimer: eventTimer, eventTimerConfiguration: eventTimerConfig)
        }.inObjectScope(.container)
    }
}
