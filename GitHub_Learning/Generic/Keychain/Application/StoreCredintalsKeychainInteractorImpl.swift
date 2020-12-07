//
//  StoreCredintalsKeychainInteractor.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 04.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

struct StoreCredintalsKeychainRequest: Equatable {
    let credentials: String
    
    static func == (lhs: StoreCredintalsKeychainRequest, rhs: StoreCredintalsKeychainRequest) -> Bool {
        return lhs.credentials == rhs.credentials
    }
}

struct StoreCredintalsKeychainResponse: Equatable {
    init() {}
}

class StoreCredintalsKeychainInteractor: Interactor {
    
    let credentialsKeychainService: CredentialsKeychainService
    
    init(
        credentialsKeychainService: CredentialsKeychainService
    ) {
        self.credentialsKeychainService = credentialsKeychainService
    }
    
    func execute(_ request: StoreCredintalsKeychainRequest) throws -> StoreCredintalsKeychainResponse {
        try credentialsKeychainService.storeCredentials(request.credentials)
        return StoreCredintalsKeychainResponse()
    }
    
    static func == (lhs: StoreCredintalsKeychainInteractor, rhs: StoreCredintalsKeychainInteractor) -> Bool {
        return true
    }
}
