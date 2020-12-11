//
//  Wireframe.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 15/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation

protocol Wireframe {
    func launchLoginAfter(_ point: LoginLaunchPoint)
    func launchAlertWith(_ title: String, message: String, actions: [AlertAction]?)
    func setOnboardingAsRoot()
    func launchDashboard(from point: DashboardLaunchPoint)
}
