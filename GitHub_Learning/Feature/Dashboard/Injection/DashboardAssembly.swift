//
//  DashboardAssembly.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 27.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore
import CleanPlatform
import Swinject

class DashboardAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(DashboardController.self, initializer: DashboardControllerImpl.init)
            .inObjectScope(.container)
        container.autoregister(DashboardPresenter.self, initializer: DashboardPresenterImpl.init)
            .initCompleted { (r, presenter) in
                (presenter as? DashboardPresenterImpl)?.view = r.resolve(DashboardView.self)
            }
        container.autoregister(DashboardViewController.self, initializer: DashboardViewController.init)
            .implements(DashboardView.self)
        container.autoregister(CryptocurrencyPriceResource.self, initializer: CryptocurrencyPriceResourceImpl.init)
        container.autoregister(CryptocurrencyParser.self, initializer: CryptocurrencyParserImpl.init)
        container.autoregister(CryptocurrencyInteractor.self, initializer: CryptocurrencyInteractor.init)
        container.autoregister(CryptocurrencyPriceFacade.self, initializer: CryptocurrencyPriceFacadeImpl.init)
        container.register(RequestCreationStep.self) { r in
            r.resolve(RequestCreationStep.self, name: NetworkingAssembly.headersCreationStepName)!
        }
    }
}
