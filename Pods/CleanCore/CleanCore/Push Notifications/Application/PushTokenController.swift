//
//  PushTokenController.swift
//  FMC
//
//  Created by Ondrej Fabian on 22/02/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

public typealias PushToken = String

public enum PushTokenError: Error {
    case tokenNotAvailable
}

public protocol PushTokenController: BaseController {
    func getToken() throws -> PushToken
}

public class PushTokenControllerImpl: BaseControllerImpl, PushTokenController {

    let pushTokenNotifier: PushTokenNotifier
    var token: PushToken?

    public init(pushTokenNotifier: PushTokenNotifier) {
        self.pushTokenNotifier = pushTokenNotifier
        super.init()
        pushTokenNotifier.loadToken(tokenUpdate: { [weak self] token in self?.pushTokenUpdate(token) }, updateFailed: { [weak self] error in self?.pushTokenFail(error) })
    }

    public func pushTokenUpdate(_ updatedToken: PushToken) {
        token = updatedToken
        notifyListenersAboutUpdate()
    }

    public func pushTokenFail(_ error: PushTokenError) {
        logWarning("\(type(of: self)).\(#function): \(error)")
        lastError = error
        notifyListenersAboutError()
        lastError = nil
    }

    public func getToken() throws -> PushToken {
        return try token ?! PushTokenError.tokenNotAvailable
    }
}
