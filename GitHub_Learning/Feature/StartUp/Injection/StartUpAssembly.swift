//
//  StartUpAssembly.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 03.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import Swinject

class StartUpAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(StartUpController.self, initializer: StartUpControllerImpl.init)
    }
}
