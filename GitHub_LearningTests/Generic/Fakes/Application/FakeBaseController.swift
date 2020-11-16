//
//  FakeBaseController.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 16/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanPlatform
import CleanCore

class FakeBaseController: BaseController {
    var _isLoading: Bool?
    var isSubscribed: Bool?
    var lastError: Error?
    var listenersNotified = false

    func isLoading() -> Bool {
        _isLoading ?? false
    }
    
    func subscribe(_ listener: Listener, errorBlock: ErrorBlock?, updateBlock: UpdateBlock?) {
        isSubscribed = true
    }

    func unsubscribe(_ listenerToBeRemoved: Listener) {
        isSubscribed = false
    }

    func numberOfSubscribers() -> Int {
        (isSubscribed ?? false) ? 1 : 0
    }
    
    func notifyListenersAboutUpdate() {
        listenersNotified = true
    }
}
