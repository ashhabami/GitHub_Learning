//
//  LoadCredintalsKeychainFacade.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 04.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol LoadCredentialsKeychainFacade {
    func loadCredentials(_ request: LoadCredentialsKeychainRequest, completion: @escaping (Result<LoadCredentialsKeychainResponse>) -> Void)
}

class LoadCredentialsKeychainFacadeImpl: CommandFacadeImpl<LoadCredentialsKeychainInteractor, LoadCredentialsKeychainRequest, LoadCredentialsKeychainResponse>, LoadCredentialsKeychainFacade {
    
    init(invoker: Invoker, receiver: LoadCredentialsKeychainInteractor) {
        super.init(invoker: invoker, receiver: receiver)
    }
    
    func loadCredentials(_ request: LoadCredentialsKeychainRequest, completion: @escaping (Result<LoadCredentialsKeychainResponse>) -> Void) {
        execute(request, completion: completion)
    }
}
