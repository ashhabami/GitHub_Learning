//
//  LoadIsFinishedFacade.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 24.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol LoadOnboardingFinishedFacade {
    func load(_ request: LoadOnboardingFinishedRequest, completion: @escaping ((Result<LoadOnboardingFinishedResponse>) -> Void))
}

final class LoadOnboardingFinishedFacadeImpl: CommandFacadeImpl<LoadOnboardingFinishedInteractor, LoadOnboardingFinishedRequest, LoadOnboardingFinishedResponse>, LoadOnboardingFinishedFacade {
    
    init(invoker: Invoker, receiver: LoadOnboardingFinishedInteractor) {
        super.init(invoker: invoker, receiver: receiver)
    }
    
    func load(_ request: LoadOnboardingFinishedRequest, completion: @escaping ((Result<LoadOnboardingFinishedResponse>) -> Void)) {
        execute(request, completion: completion)
    }
}
