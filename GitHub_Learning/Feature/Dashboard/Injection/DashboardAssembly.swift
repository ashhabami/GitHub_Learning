//
//  DashboardAssembly.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 27.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import Swinject

class DashboardAssembly: Assembly {
    func assemble(container: Container) {
        // Takhle: Deinitnout se někdy ty singletony,který jsou .inObjectScope(.container)??
        // Nezabírají zbytečně moc pamět i když je pak není potřeba??
        container.autoregister(DashboardController.self, initializer: DashboardControllerImpl.init)
            .inObjectScope(.container)
        container.autoregister(DashboardPresenter.self, initializer: DashboardPresenterImpl.init)
            .initCompleted { (r, presenter) in
            (presenter as? DashboardPresenterImpl)?.view = r.resolve(DashboardView.self)
            }
        container.autoregister(DashboardViewController.self, initializer: DashboardViewController.init)
            .implements(DashboardView.self)
    }
}
