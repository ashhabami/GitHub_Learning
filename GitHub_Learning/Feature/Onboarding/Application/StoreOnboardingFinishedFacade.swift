//
//  StoreFinishedOnboardingFacade.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 25.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol StoreOnboardingFinishedFacade {
    func store(_ request: StoreOnboardingFinishedRequest, _ completion: @escaping ((Result<StoreOnboardingFinishedResponse>) -> Void))
}

final class StoreOnboardingFinishedFacadeImpl: CommandFacadeImpl<StoreOnboardingFinishedInteractor, StoreOnboardingFinishedRequest, StoreOnboardingFinishedResponse>, StoreOnboardingFinishedFacade {
    
    init(invoker: Invoker, receiver: StoreOnboardingFinishedInteractor) {
        super.init(invoker: invoker, receiver: receiver)
    }
    
    func store(_ request: StoreOnboardingFinishedRequest, _ completion: @escaping ((Result<StoreOnboardingFinishedResponse>) -> Void)) {
        execute(request, completion: completion)
    }
}
