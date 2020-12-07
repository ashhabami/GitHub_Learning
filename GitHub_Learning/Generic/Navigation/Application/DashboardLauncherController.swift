//
//  DashboardLauncherController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 27.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol DashboardLauncherController: BaseController {
    func launchDashboardModallyWith(_ email: String)
    func launchDashboardAsRootWith(_ email: String)
}

final class DashboardLauncherControllerImpl: BaseControllerImpl {
    private let wireframe: Wireframe
    private let dashboardController: DashboardController
    
    init(
        wireframe: Wireframe,
        dashboardController: DashboardController
    ) {
        self.wireframe = wireframe
        self.dashboardController = dashboardController
    }
}

extension DashboardLauncherControllerImpl: DashboardLauncherController {
    func launchDashboardAsRootWith(_ email: String) {
        dashboardController.setEmail(email)
        wireframe.setDashboardAsRoot()
    }
    
    func launchDashboardModallyWith(_ email: String) {
        dashboardController.setEmail(email)
        wireframe.launchDashboard()
    }
}
