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
    func startUp()
}

final class StartUpControllerImpl: BaseControllerImpl {
    private let loadOnboardingFinishedFacade: LoadOnboardingFinishedFacade
    private let credentialKeychainController: CredentialKeychainController
    private let wireframe: Wireframe
    private let dashboardLauncherController: DashboardLauncherController
    
    init(
        loadOnboardingFinishedFacade: LoadOnboardingFinishedFacade,
        wireframe: Wireframe,
        credentialKeychainController: CredentialKeychainController,
        dashboardLauncherController: DashboardLauncherController
    ) {
        self.loadOnboardingFinishedFacade = loadOnboardingFinishedFacade
        self.wireframe = wireframe
        self.credentialKeychainController = credentialKeychainController
        self.dashboardLauncherController = dashboardLauncherController
    }
}

extension StartUpControllerImpl: StartUpController {
    func startUp() {
        loadOnboardingFinishedFacade.load(LoadOnboardingFinishedRequest()) { onboardingResponse in
            if case .success(let response) = onboardingResponse, response.isFinished {
                self.checkCredentials()
            } else {
                self.wireframe.setOnboardingAsRoot()
            }
        }
    }
    
    private func checkCredentials() {
        credentialKeychainController.loadCredentials { credintalResponse in
            switch credintalResponse {
            case .success(let credResponse):
                self.dashboardLauncherController.launchDashboardAsRootWith(credResponse.credentials)
            case .failure:
                self.wireframe.setLoginAsRoot()
            }
        }
    }
}
