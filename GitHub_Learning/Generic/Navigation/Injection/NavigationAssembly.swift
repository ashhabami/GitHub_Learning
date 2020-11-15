//
//  NavigationAssembly.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 13/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import Swinject

final class NavigationAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(LoginLauncherController.self, initializer: LoginLauncherControllerImpl.init)
        container.autoregister(Wireframe.self, initializer: WireframeImpl.init)
    }

}
