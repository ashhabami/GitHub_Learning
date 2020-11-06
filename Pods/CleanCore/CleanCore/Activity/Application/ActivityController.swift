//
//  ActivityController.swift
//  Cleancore
//
//  Created by Ondrej Fabian on 11/10/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

public typealias ActivityId = Int

public protocol ActivityController: BaseController {
    func activityStarted(with id: ActivityId)
    func activityStopped(with id: ActivityId)
}

public class ActivityControllerImpl: BaseControllerImpl, ActivityController {

    var activities: Set<ActivityId> = []

    public override func isLoading() -> Bool {
        return !activities.isEmpty
    }

    public func activityStarted(with id: ActivityId) {
        activities.insert(id)
        notifyListenersAboutUpdate()
    }

    public func activityStopped(with id: ActivityId) {
        activities.remove(id)
        notifyListenersAboutUpdate()
    }
}
