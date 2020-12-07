//
//  LoadCredintalsKeychainFacade.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 04.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol LoadCredintalsKeychainFacade {
    func loadCredintals(_ request: LoadCredintalsKeychainRequest, completion: @escaping (Result<LoadCredintalsKeychainResponse>) -> Void)
}

class LoadCredintalsKeychainFacadeImpl: CommandFacadeImpl<LoadCredintalsKeychainInteractor, LoadCredintalsKeychainRequest, LoadCredintalsKeychainResponse>, LoadCredintalsKeychainFacade {
    
    init(invoker: Invoker, receiver: LoadCredintalsKeychainInteractor) {
        super.init(invoker: invoker, receiver: receiver)
    }
    
    func loadCredintals(_ request: LoadCredintalsKeychainRequest, completion: @escaping (Result<LoadCredintalsKeychainResponse>) -> Void) {
        execute(request, completion: completion)
    }
}
