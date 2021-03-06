//
//  LoginLauncherController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 13/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore
import CleanPlatform

enum LoginLaunchPoint {
    case onboarding
    case dashboard
    case start
}

protocol LoginLauncherController: BaseController {
    func launchLoginAfter(_ point: LoginLaunchPoint)
}

class LoginLauncherControllerImpl: BaseControllerImpl {
    private let wireframe: Wireframe
    
    init(
        wireframe: Wireframe
    ) {
        self.wireframe = wireframe
    }
}

extension LoginLauncherControllerImpl: LoginLauncherController {
    func launchLoginAfter(_ point: LoginLaunchPoint) {
        wireframe.launchLoginAfter(point)
    }
}
