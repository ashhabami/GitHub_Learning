//
//  DeleteCredintalsKeychainInteractor.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 04.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

struct DeleteCredintalsKeychainRequest: Equatable {
    init() {}
}

struct DeleteCredintalsKeychainResponse: Equatable {
    init() {}
}

class DeleteCredintalsKeychainInteractor: Interactor {
    
    let credentialsKeychainService: CredentialsKeychainService
    
    init(
        credentialsKeychainService: CredentialsKeychainService
    ) {
        self.credentialsKeychainService = credentialsKeychainService
    }
    
    func execute(_ request: DeleteCredintalsKeychainRequest) throws -> DeleteCredintalsKeychainResponse {
        try credentialsKeychainService.deleteCredentials()
        return DeleteCredintalsKeychainResponse()
    }
    
    static func == (lhs: DeleteCredintalsKeychainInteractor, rhs: DeleteCredintalsKeychainInteractor) -> Bool {
        return true
    }
}
