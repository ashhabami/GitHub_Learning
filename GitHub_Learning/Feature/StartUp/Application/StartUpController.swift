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
    private let loginLauncherController: LoginLauncherController
    private let dashboardLauncherController: DashboardLauncherController
    private let wireframe: Wireframe
    
    init(
        loadOnboardingFinishedFacade: LoadOnboardingFinishedFacade,
        loginLauncherController: LoginLauncherController,
        credentialKeychainController: CredentialKeychainController,
        dashboardLauncherController: DashboardLauncherController,
        wireframe: Wireframe
    ) {
        self.loadOnboardingFinishedFacade = loadOnboardingFinishedFacade
        self.loginLauncherController = loginLauncherController
        self.credentialKeychainController = credentialKeychainController
        self.dashboardLauncherController = dashboardLauncherController
        self.wireframe = wireframe
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
        credentialKeychainController.loadCredentials { credentialResponse in
            switch credentialResponse {
            case .success(let credResponse):
                self.dashboardLauncherController.launchDashboardWith(credResponse.credentials, from: .startUp)
            case .failure:
                self.loginLauncherController.launchLoginAfter(.start)
            }
        }
    }
}
