//
//  KeychainController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 05.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanPlatform
import CleanCore

protocol CredentialKeychainController: BaseController {
    func storeCredentials(_ credintals: String)
    func loadCredentials(_ completion: @escaping (Result<LoadCredentialsKeychainResponse>) -> Void)
    func deleteCredentials()
}

final class CredentialKeychainControllerImpl: BaseControllerImpl {
    private let storeCredentialsKeychainFacade: StoreCredentialsKeychainFacade
    private let loadCredentialsKeychainFacade: LoadCredentialsKeychainFacade
    private let deleteCredentialsKeychainFacade: DeleteCredintalsKeychainFacade
    
    init(
        storeCredentialsKeychainFacade: StoreCredentialsKeychainFacade,
        loadCredentialsKeychainFacade: LoadCredentialsKeychainFacade,
        deleteCredentialsKeychainFacade: DeleteCredintalsKeychainFacade
    ) {
        self.storeCredentialsKeychainFacade = storeCredentialsKeychainFacade
        self.loadCredentialsKeychainFacade = loadCredentialsKeychainFacade
        self.deleteCredentialsKeychainFacade = deleteCredentialsKeychainFacade
    }
}

extension CredentialKeychainControllerImpl: CredentialKeychainController {
    func deleteCredentials() {
        deleteCredentialsKeychainFacade.deleteCredentials(DeleteCredentialsKeychainRequest()) { [weak self] response in
            guard let self = self else { return }
            self.handleResult(response) { _ in
                print("Credintals successfully deleted")
            }
        }
    }
    
    func loadCredentials(_ completion: @escaping (Result<LoadCredentialsKeychainResponse>) -> Void) {
        loadCredentialsKeychainFacade.loadCredentials(LoadCredentialsKeychainRequest(), completion: completion)
    }
    
    func storeCredentials(_ credintals: String) {
        storeCredentialsKeychainFacade.storeCredentials(StoreCredentialsKeychainRequest(credentials: credintals)) { [weak self] response in
            guard let self = self else { return }
            self.handleResult(response) { _ in
                print("Credintals successfully stored")
            }
        }
    }
}
