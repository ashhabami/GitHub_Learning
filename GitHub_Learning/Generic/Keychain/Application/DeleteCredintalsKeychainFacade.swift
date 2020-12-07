//
//  DeleteCredintalsKeychainFacade.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 04.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol DeleteCredintalsKeychainFacade {
    func deleteCredentials(_ request: DeleteCredentialsKeychainRequest, completion: @escaping (Result<DeleteCredentialsKeychainResponse>) -> Void)
}

class DeleteCredintalsKeychainFacadeImpl: CommandFacadeImpl<DeleteCredentialsKeychainInteractor, DeleteCredentialsKeychainRequest, DeleteCredentialsKeychainResponse>, DeleteCredintalsKeychainFacade {
    
    init(invoker: Invoker, receiver: DeleteCredentialsKeychainInteractor) {
        super.init(invoker: invoker, receiver: receiver)
    }
    
    func deleteCredentials(_ request: DeleteCredentialsKeychainRequest, completion: @escaping (Result<DeleteCredentialsKeychainResponse>) -> Void) {
        execute(request, completion: completion)
    }
}
