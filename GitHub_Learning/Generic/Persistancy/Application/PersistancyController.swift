//
//  OnboardingPersistancyController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 17/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol PersistancyController: BaseController {
    func setIsOnboardingFinished(_ value: Bool)
    func IsOnboardingFinished() -> Bool
}

class PersistancyControllerImpl: BaseControllerImpl {
    private let userDefaults = UserDefaults.standard
    private let key = "onboardingFinished"
}

extension PersistancyControllerImpl: PersistancyController {
    func setIsOnboardingFinished(_ value: Bool) {
        userDefaults.set(value, forKey: key)
    }
    
    func IsOnboardingFinished() -> Bool {
        return userDefaults.bool(forKey: key)
    }
}
