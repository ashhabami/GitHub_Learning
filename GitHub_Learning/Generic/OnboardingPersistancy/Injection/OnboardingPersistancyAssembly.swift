//
//  OnboardingPersistancyAssembly.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 04.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import Swinject
import CleanCore

class OnboardingPersistancyAssembly: Assembly {
    func assemble(container: Container) {
        container.register(OnboardingResource.self) { r in
            let localStorage = r.resolve(LocalStorageFactory.self)!.makeUserDefaultsStorage()
            return OnboardingResourceImpl(localStorage: localStorage)
        }
        container.autoregister(LoadOnboardingFinishedInteractor.self, initializer: LoadOnboardingFinishedInteractor.init)
        container.autoregister(StoreOnboardingFinishedInteractor.self, initializer: StoreOnboardingFinishedInteractor.init)
        container.autoregister(StoreOnboardingFinishedFacade.self, initializer: StoreOnboardingFinishedFacadeImpl.init)
        container.autoregister(LoadOnboardingFinishedFacade.self, initializer: LoadOnboardingFinishedFacadeImpl.init)
    }
}
