//
//  StoreCredintalsKeychainFacade.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 04.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol StoreCredentialsKeychainFacade {
    func storeCredentials(_ request: StoreCredentialsKeychainRequest, completion: @escaping (Result<StoreCredentialsKeychainResponse>) -> Void)
}

class StoreCredentialsKeychainFacadeImpl: CommandFacadeImpl<StoreCredentialsKeychainInteractor, StoreCredentialsKeychainRequest, StoreCredentialsKeychainResponse>, StoreCredentialsKeychainFacade {
    
    init(invoker: Invoker, receiver: StoreCredentialsKeychainInteractor) {
        super.init(invoker: invoker, receiver: receiver)
    }
    
    func storeCredentials(_ request: StoreCredentialsKeychainRequest, completion: @escaping (Result<StoreCredentialsKeychainResponse>) -> Void) {
        execute(request, completion: completion)
    }
}
