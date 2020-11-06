//
//  PushNotificationsNotifier.swift
//  FMC
//
//  Created by Ondrej Fabian on 02/03/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

public typealias PushNotificationBlock = ValueBlock<PushNotification>

public protocol PushNotificationsNotifier {
    func registerPushUpdate(pushNotificationUpdate: @escaping PushNotificationBlock)
    func handleArrivedNotification(dictionary: [AnyHashable : Any], backgroundPush: Bool)
}
