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

protocol LoginLauncherController: BaseController {
    func launchLogin()
}

class LoginLauncherControllerImpl: BaseControllerImpl {
    let wireframe: Wireframe
    
    init(wireframe: Wireframe) {
        self.wireframe = wireframe
    }
}

extension LoginLauncherControllerImpl: LoginLauncherController {
    func launchLogin() {
        wireframe.launchLogin()
    }
}
