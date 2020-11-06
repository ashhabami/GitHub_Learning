//
//  PushTokenNotifierImpl.swift
//  CleanPlatform
//
//  Created by Ondrej Fabian on 03/11/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import CleanCore
import UserNotifications
import UIKit

public class PushTokenNotifierImpl: PushTokenNotifier {

    let pushNotificationsNotifier: PushNotificationsNotifier

    public init(pushNotificationsNotifier: PushNotificationsNotifier) {
        self.pushNotificationsNotifier = pushNotificationsNotifier
    }

    public func loadToken(tokenUpdate updated: @escaping PushTokenUpdateBlock, updateFailed: @escaping PushTokenFailBlock) {
        logWarning("To enable remote push notifications and silence this warning, overregister PushTokenNotifier.")
    }
}
