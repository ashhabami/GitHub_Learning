//
//  LoginController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 08.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol LoginController: BaseController {
    func logInWith(_ email: String)
}

final class LoginControllerImpl: BaseControllerImpl {
    private let dashboardLauncherController: DashboardLauncherController
    private let keychainController: CredentialKeychainController
    
    init(
        dashboardLauncherController: DashboardLauncherController,
        keychainController: CredentialKeychainController
    ) {
        self.dashboardLauncherController = dashboardLauncherController
        self.keychainController = keychainController
    }
}

extension LoginControllerImpl: LoginController {
    func logInWith(_ email: String) {
        keychainController.storeCredentials(email)
        dashboardLauncherController.launchDashboardWith(email, from: .login)
    }
}
