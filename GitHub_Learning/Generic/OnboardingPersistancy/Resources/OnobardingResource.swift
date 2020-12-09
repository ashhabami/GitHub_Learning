//
//  OnobardingResource.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 23.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanPlatform
import CleanCore

typealias OnboardingResource = OnboardingFinishedService

class OnboardingResourceImpl: OnboardingResource {
    
    private let localStorage: LocalStorage
    private let onboardingIsFinishedKey = "OnboardingKey"
    
    init(
        localStorage: LocalStorage
    ) {
        self.localStorage = localStorage
    }
    
    func loadIsOnboardingFinished() throws -> Bool {
        return (try? localStorage.loadSetting(onboardingIsFinishedKey)) ?? false
    }
    
    func storeIsOnboardingFinished(_ isFinished: Bool) {
        localStorage.storeSetting(onboardingIsFinishedKey, value: isFinished)
    }
}
