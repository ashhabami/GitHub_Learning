//
//  PushNotificationsController.swift
//  FMC
//
//  Created by Ondrej Fabian on 02/03/2017.
//  Copyright (c) 2017 Cleverlance. All rights reserved.
//

public protocol PushNotificationsController: BaseController {
    func getNotification() -> PushNotification?
}

public final class PushNotificationsControllerImpl: BaseControllerImpl, PushNotificationsController {

    private let pushNotificationsNotifier: PushNotificationsNotifier
    private var notification: PushNotification?

    public init(pushNotificationsNotifier: PushNotificationsNotifier) {
        self.pushNotificationsNotifier = pushNotificationsNotifier
        super.init()
        pushNotificationsNotifier.registerPushUpdate(pushNotificationUpdate: newNotification)
    }

    public func getNotification() -> PushNotification? {
        return notification
    }

    private func newNotification(_ notification: PushNotification) {
        self.notification = notification
        notifyListenersAboutUpdate()
        self.notification = nil
    }
}
