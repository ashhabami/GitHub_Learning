//
//  EventTimerController.swift
//  CleanCore
//
//  Created by Ondrej Fabian on 30/08/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

public protocol EventTimerController: BaseController {

}

public class EventTimerControllerImpl: BaseControllerImpl, EventTimerController {

    private let eventTimer: EventTimer
    private let eventTimerConfiguration: EventTimerConfiguration

    public init(eventTimer: EventTimer, eventTimerConfiguration: EventTimerConfiguration) {
        self.eventTimer = eventTimer
        self.eventTimerConfiguration = eventTimerConfiguration
    }

    public override func subscribe(_ listener: Listener, errorBlock: ErrorBlock?, updateBlock: UpdateBlock?) {
        super.subscribe(listener, errorBlock: errorBlock, updateBlock: updateBlock)
        eventTimer.start(eventTimerConfiguration.getFrequency(), closure: eventFired)
    }

    private func eventFired() {
        if numberOfSubscribers() > 0 {
            notifyListenersAboutUpdate()
        } else {
            eventTimer.stop()
        }
    }
}
