//
//  PushNotificationsAssembly.swift
//  FMC
//
//  Created by Ondrej Fabian on 22/02/2017.
//  Copyright (c) 2017 Cleverlance. All rights reserved.
//

import Foundation
import Swinject
import CleanCore

final class PushNotificationsAssembly: Assembly {

    func assemble(container: Container) {
        container.register(PushNotificationsNotifier.self) { r in
            return PushNotificationsNotifierImpl()
        }.inObjectScope(.container)

        container.register(PushNotificationsController.self) { r in
            let pushNotificationsNotifier = r.resolve(PushNotificationsNotifier.self)!
            return PushNotificationsControllerImpl(pushNotificationsNotifier: pushNotificationsNotifier)
        }.inObjectScope(.container)

        container.register(PushTokenNotifier.self) { r in
            let pushNotificationsNotifier = r.resolve(PushNotificationsNotifier.self)!
            return PushTokenNotifierImpl(pushNotificationsNotifier: pushNotificationsNotifier)
        }

        container.register(PushTokenController.self) { r in
            let pushTokenNotifier = r.resolve(PushTokenNotifier.self)!
            return PushTokenControllerImpl(pushTokenNotifier: pushTokenNotifier)
        }.inObjectScope(.container)
    }
}
