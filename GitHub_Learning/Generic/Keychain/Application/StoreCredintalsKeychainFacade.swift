//
//  StoreCredintalsKeychainFacade.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 04.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol StoreCredintalsKeychainFacade {
    func storeCredintals(_ request: StoreCredintalsKeychainRequest, completion: @escaping (Result<StoreCredintalsKeychainResponse>) -> Void)
}

class StoreCredintalsKeychainFacadeImpl: CommandFacadeImpl<StoreCredintalsKeychainInteractor, StoreCredintalsKeychainRequest, StoreCredintalsKeychainResponse>, StoreCredintalsKeychainFacade {
    
    init(invoker: Invoker, receiver: StoreCredintalsKeychainInteractor) {
        super.init(invoker: invoker, receiver: receiver)
    }
    
    func storeCredintals(_ request: StoreCredintalsKeychainRequest, completion: @escaping (Result<StoreCredintalsKeychainResponse>) -> Void) {
        execute(request, completion: completion)
    }
}
