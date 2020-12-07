//
//  LoadCredintalsKeyChainInteractor.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 04.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

struct LoadCredintalsKeychainRequest: Equatable {
    init() {}
}

struct LoadCredintalsKeychainResponse: Equatable {
    let credentials: String
    
    static func == (lhs: LoadCredintalsKeychainResponse, rhs: LoadCredintalsKeychainResponse) -> Bool {
        return lhs.credentials == rhs.credentials
    }
}

class LoadCredintalsKeychainInteractor: Interactor {
    
    let credentialsKeychainService: CredentialsKeychainService
    
    init(
        credentialsKeychainService: CredentialsKeychainService
    ) {
        self.credentialsKeychainService = credentialsKeychainService
    }
    // Proč když je tanhle metoda throws tak nemusim dávat do catch block nebo force try??
    func execute(_ request: LoadCredintalsKeychainRequest) throws -> LoadCredintalsKeychainResponse {
        let credentials = try credentialsKeychainService.loadCredentials()
        return LoadCredintalsKeychainResponse(credentials: credentials)
    }
    
    static func == (lhs: LoadCredintalsKeychainInteractor, rhs: LoadCredintalsKeychainInteractor) -> Bool {
        return true
    }
}
