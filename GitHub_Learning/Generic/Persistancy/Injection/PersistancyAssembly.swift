//
//  PersistancyAssembly.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 17/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import Swinject

class PersistancyAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(PersistancyController.self, initializer: PersistancyControllerImpl.init)
            .inObjectScope(.container)
    }
}
