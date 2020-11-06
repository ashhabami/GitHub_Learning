//
//  ActivityIndicatorAssembly.swift
//  CleanPlatform
//
//  Created by Ondrej Fabian on 01/11/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import CleanCore

final class ActivityIndicatorAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(ActivityController.self, initializer: ActivityControllerImpl.init).inObjectScope(.container)
    }
}
