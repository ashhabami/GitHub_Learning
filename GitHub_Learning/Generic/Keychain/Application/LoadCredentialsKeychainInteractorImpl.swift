//
//  LoadCredintalsKeyChainInteractor.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 04.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

struct LoadCredentialsKeychainRequest: Equatable {
    init() {}
}

struct LoadCredentialsKeychainResponse: Equatable {
    let credentials: String
    
    static func == (lhs: LoadCredentialsKeychainResponse, rhs: LoadCredentialsKeychainResponse) -> Bool {
        return lhs.credentials == rhs.credentials
    }
}

class LoadCredentialsKeychainInteractor: Interactor {
    
    let credentialsKeychainService: CredentialsKeychainService
    
    init(
        credentialsKeychainService: CredentialsKeychainService
    ) {
        self.credentialsKeychainService = credentialsKeychainService
    }
    
    func execute(_ request: LoadCredentialsKeychainRequest) throws -> LoadCredentialsKeychainResponse {
        let credentials = try credentialsKeychainService.loadCredentials()
        return LoadCredentialsKeychainResponse(credentials: credentials)
    }
    
    static func == (lhs: LoadCredentialsKeychainInteractor, rhs: LoadCredentialsKeychainInteractor) -> Bool {
        return true
    }
}
