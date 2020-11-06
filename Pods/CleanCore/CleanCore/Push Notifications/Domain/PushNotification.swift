//
//  PushNotification.swift
//  FMC
//
//  Created by Ondrej Fabian on 02/03/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

public struct PushNotification {

    public let payload: [String: Any]
    public let receivedFromBackground: Bool
    public let badgeNumber: Int?
    public let contentAvailable: Int?
    public let category: String?
    public let threadIdentifier: String?

    public init(payload: [String: Any], receivedFromBackground: Bool, badgeNumber: Int?, contentAvailable: Int?, category: String?, threadIdentifier: String?) {
        self.payload = payload
        self.receivedFromBackground = receivedFromBackground
        self.badgeNumber = badgeNumber
        self.contentAvailable = contentAvailable
        self.category = category
        self.threadIdentifier = threadIdentifier
    }

    public init(payload: [String: Any], receivedFromBackground: Bool) {
        self.init(payload: payload, receivedFromBackground: receivedFromBackground, badgeNumber: nil, contentAvailable: nil, category: nil, threadIdentifier: nil)
    }
}
