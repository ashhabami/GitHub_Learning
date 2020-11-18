//
//  FakeBaseController.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 16/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import CleanCore

class TestController: BaseController {

    var lastError: Error?
    var loading: Bool = false

    weak var listener: Listener?
    var error: ErrorBlock?
    var update: UpdateBlock?
    var subscriptions = 0

    public init() { }

    func isLoading() -> Bool {
        return loading
    }

    func subscribe(_ listener: Listener, errorBlock: ErrorBlock?, updateBlock: UpdateBlock?) {
        error = errorBlock
        update = updateBlock
        self.listener = listener
    }

    func unsubscribe(_ listenerToBeRemoved: Listener) {
        update = nil
        error = nil
        self.listener = nil
    }

    func notifyListenersAboutUpdate() {
        update?(self)
    }

    func notifyListenersAboutError() {
        error?(self)
    }

    func numberOfSubscribers() -> Int {
        return subscriptions
    }
}
