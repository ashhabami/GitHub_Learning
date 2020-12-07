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
    func deleteCredintals(_ request: DeleteCredintalsKeychainRequest, completion: @escaping (Result<DeleteCredintalsKeychainResponse>) -> Void)
}

class DeleteCredintalsKeychainFacadeImpl: CommandFacadeImpl<DeleteCredintalsKeychainInteractor, DeleteCredintalsKeychainRequest, DeleteCredintalsKeychainResponse>, DeleteCredintalsKeychainFacade {
    
    init(invoker: Invoker, receiver: DeleteCredintalsKeychainInteractor) {
        super.init(invoker: invoker, receiver: receiver)
    }
    
    func deleteCredintals(_ request: DeleteCredintalsKeychainRequest, completion: @escaping (Result<DeleteCredintalsKeychainResponse>) -> Void) {
        execute(request, completion: completion)
    }
}
