//
//  DeleteCredintalsKeychainInteractor.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 04.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

struct DeleteCredentialsKeychainRequest: Equatable {
    init() {}
}

struct DeleteCredentialsKeychainResponse: Equatable {
    init() {}
}

class DeleteCredentialsKeychainInteractor: Interactor {
    
    let credentialsKeychainService: CredentialsKeychainService
    
    init(
        credentialsKeychainService: CredentialsKeychainService
    ) {
        self.credentialsKeychainService = credentialsKeychainService
    }
    
    func execute(_ request: DeleteCredentialsKeychainRequest) throws -> DeleteCredentialsKeychainResponse {
        try credentialsKeychainService.deleteCredentials()
        return DeleteCredentialsKeychainResponse()
    }
    
    static func == (lhs: DeleteCredentialsKeychainInteractor, rhs: DeleteCredentialsKeychainInteractor) -> Bool {
        return true
    }
}
