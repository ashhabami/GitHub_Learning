//
//  StartUpController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 03.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol StartUpController: BaseController {
    func isOnboardingFinished(_ request: LoadOnboardingFinishedRequest, _ completion: @escaping (Result<LoadOnboardingFinishedResponse>) -> Void)
    func startUpWithOnboardingFinished(_ isOnboardingFinished: Bool)
}

final class StartUpControllerImpl: BaseControllerImpl {
    private let loadOnboardingFinishedFacade: LoadOnboardingFinishedFacade
    private let wireframe: Wireframe
    
    init(
        loadOnboardingFinishedFacade: LoadOnboardingFinishedFacade,
        wireframe: Wireframe
    ) {
        self.loadOnboardingFinishedFacade = loadOnboardingFinishedFacade
        self.wireframe = wireframe
    }
}

extension StartUpControllerImpl: StartUpController {
    func isOnboardingFinished(_ request: LoadOnboardingFinishedRequest, _ completion: @escaping (Result<LoadOnboardingFinishedResponse>) -> Void) {
        loadOnboardingFinishedFacade.load(request, completion: completion)
    }
    
    func startUpWithOnboardingFinished(_ isOnboardingFinished: Bool) {
        wireframe.setRootViewFor(isOnboardingFinished)
    }
}
