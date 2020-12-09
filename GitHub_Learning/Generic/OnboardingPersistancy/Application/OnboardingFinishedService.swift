//
//  OnboardingFinishedService.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 24.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation

protocol OnboardingFinishedService {
    func loadIsOnboardingFinished() throws -> Bool
    func storeIsOnboardingFinished(_ isFinished: Bool)
}
