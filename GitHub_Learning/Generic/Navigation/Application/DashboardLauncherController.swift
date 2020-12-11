//
//  DashboardLauncherController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 27.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

enum DashboardLaunchPoint {
    case startUp
    case login
}

protocol DashboardLauncherController: BaseController {
    func launchDashboardWith(_ email: String, from launchPoint: DashboardLaunchPoint)
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
    func launchDashboardWith(_ email: String, from launchPoint: DashboardLaunchPoint) {
        dashboardController.setEmail(email)
        wireframe.launchDashboard(from: launchPoint)
    }
}
