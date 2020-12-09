//
//  NavigationAssembly.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 13/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import Swinject
import CleanCore
import CleanPlatform

final class NavigationAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(LoginLauncherController.self, initializer: LoginLauncherControllerImpl.init)
            .inObjectScope(.container)
        container.autoregister(Wireframe.self, initializer: WireframeImpl.init)
        container.register(UIWindow.self) { _ in UIApplication.shared.windows.first! }
        container.autoregister(DashboardLauncherController.self, initializer: DashboardLauncherControllerImpl.init)
    }
}
