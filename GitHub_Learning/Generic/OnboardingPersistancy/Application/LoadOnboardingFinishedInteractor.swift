//
//  LoadIsFinishedInteractor.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 24.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

struct LoadOnboardingFinishedRequest: Equatable {
    init() {}
}

struct LoadOnboardingFinishedResponse: Equatable {
    let isFinished: Bool
    
    public static func == (lhs: LoadOnboardingFinishedResponse, rhs: LoadOnboardingFinishedResponse) -> Bool {
        return lhs.isFinished == rhs.isFinished
    }
}

final class LoadOnboardingFinishedInteractor: Interactor {
    
    let onboardingFinishedService: OnboardingFinishedService
    
    init(
        onboardingFinishedService: OnboardingFinishedService
    ) {
        self.onboardingFinishedService = onboardingFinishedService
    }
    
    func execute(_ request: LoadOnboardingFinishedRequest) throws -> LoadOnboardingFinishedResponse {
        let isFinished = try onboardingFinishedService.loadIsOnboardingFinished()
        return LoadOnboardingFinishedResponse(isFinished: isFinished)
    }
    
    static func == (lhs: LoadOnboardingFinishedInteractor, rhs: LoadOnboardingFinishedInteractor) -> Bool {
        return true
    }
}
