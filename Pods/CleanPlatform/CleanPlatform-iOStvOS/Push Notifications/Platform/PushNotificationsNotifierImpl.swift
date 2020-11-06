//
//  PushNotificationsNotifierImpl.swift
//  FMC
//
//  Created by Vít Míchal on 04.04.17.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import CleanCore

public class PushNotificationsNotifierImpl: PushNotificationsNotifier {

    private var pushNotificationUpdate: PushNotificationBlock?

    public init() { }

    public func registerPushUpdate(pushNotificationUpdate: @escaping PushNotificationBlock) {
        self.pushNotificationUpdate = pushNotificationUpdate
    }

    public func handleArrivedNotification(dictionary: [AnyHashable : Any], backgroundPush: Bool) {
        guard let payload = dictionary as? [String: Any] else { return }
        let pushNotification = convertPayloadToPush(payload: payload, backgroundPush: backgroundPush)
        pushNotificationUpdate?(pushNotification)
    }

    private func convertPayloadToPush(payload: [String: Any], backgroundPush: Bool) -> PushNotification {
        let pushNotification: PushNotification
        if let apsPayload = payload["aps"] as? [String: Any] {
            let badgeNumber = apsPayload["badge"] as? Int
            let contentAvailable = apsPayload["content-available"] as? Int
            let category = apsPayload["category"] as? String
            let threadIdentifier = apsPayload["thread-id"] as? String
            pushNotification = PushNotification(payload: payload, receivedFromBackground: backgroundPush, badgeNumber: badgeNumber, contentAvailable: contentAvailable, category: category, threadIdentifier: threadIdentifier)
        } else {
            pushNotification = PushNotification(payload: payload, receivedFromBackground: backgroundPush)
        }
        return pushNotification
    }
}
