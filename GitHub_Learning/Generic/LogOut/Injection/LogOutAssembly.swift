//
//  LogOutAssembly.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 07.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import Swinject

class LogOutAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(LogOutController.self, initializer: LogOutControllerImpl.init)
    }
}
