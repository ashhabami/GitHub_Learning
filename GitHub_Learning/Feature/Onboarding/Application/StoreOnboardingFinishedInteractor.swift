//
//  StoreIsFinishedInteractor.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 24.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

struct StoreOnboardingFinishedRequest: Equatable {
    let isFinished: Bool
    
    public static func == (lhs: StoreOnboardingFinishedRequest, rhs: StoreOnboardingFinishedRequest) -> Bool {
        return lhs.isFinished == rhs.isFinished
    }
}

struct StoreOnboardingFinishedResponse: Equatable {
    init() {}
}

final class StoreOnboardingFinishedInteractor: Interactor {
    
    let onboardingFinishedService: OnboardingFinishedService
    
    init(
        onboardingFinishedService: OnboardingFinishedService
    ) {
        self.onboardingFinishedService = onboardingFinishedService
    }
    
    func execute(_ request: StoreOnboardingFinishedRequest) throws -> StoreOnboardingFinishedResponse {
        onboardingFinishedService.storeIsOnboardingFinished(request.isFinished)
        return StoreOnboardingFinishedResponse()
    }
    
    static func == (lhs: StoreOnboardingFinishedInteractor, rhs: StoreOnboardingFinishedInteractor) -> Bool {
        return true
    }
}
