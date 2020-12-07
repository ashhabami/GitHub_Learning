//
//  StoreCredintalsKeychainInteractor.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 04.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

struct StoreCredentialsKeychainRequest: Equatable {
    let credentials: String
    
    static func == (lhs: StoreCredentialsKeychainRequest, rhs: StoreCredentialsKeychainRequest) -> Bool {
        return lhs.credentials == rhs.credentials
    }
}

struct StoreCredentialsKeychainResponse: Equatable {
    init() {}
}

class StoreCredentialsKeychainInteractor: Interactor {
    
    let credentialsKeychainService: CredentialsKeychainService
    
    init(
        credentialsKeychainService: CredentialsKeychainService
    ) {
        self.credentialsKeychainService = credentialsKeychainService
    }
    
    func execute(_ request: StoreCredentialsKeychainRequest) throws -> StoreCredentialsKeychainResponse {
        try credentialsKeychainService.storeCredentials(request.credentials)
        return StoreCredentialsKeychainResponse()
    }
    
    static func == (lhs: StoreCredentialsKeychainInteractor, rhs: StoreCredentialsKeychainInteractor) -> Bool {
        return true
    }
}
