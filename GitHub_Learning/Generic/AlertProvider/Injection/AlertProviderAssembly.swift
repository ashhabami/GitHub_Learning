//
//  AlertProviderAssembly.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 19/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import Swinject

class AlertProviderAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(AlertProviderController.self, initializer: AlertProviderControllerImpl.init)
            .inObjectScope(.container)
    }
}
