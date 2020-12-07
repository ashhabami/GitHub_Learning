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
    func storeCredintals(_ credintals: String)
    func loadCredintals(_ completion: @escaping (Result<LoadCredintalsKeychainResponse>) -> Void)
    func deleteCredintals()
}

final class CredentialKeychainControllerImpl: BaseControllerImpl {
    private let storeCreditalsKeychainFacade: StoreCredintalsKeychainFacade
    private let loadCreditalsKeychainFacade: LoadCredintalsKeychainFacade
    private let deleteCreditalsKeychainFacade: DeleteCredintalsKeychainFacade
    
    init(
        storeCreditalsKeychainFacade: StoreCredintalsKeychainFacade,
        loadCreditalsKeychainFacade: LoadCredintalsKeychainFacade,
        deleteCreditalsKeychainFacade: DeleteCredintalsKeychainFacade
    ) {
        self.storeCreditalsKeychainFacade = storeCreditalsKeychainFacade
        self.loadCreditalsKeychainFacade = loadCreditalsKeychainFacade
        self.deleteCreditalsKeychainFacade = deleteCreditalsKeychainFacade
    }
}

extension CredentialKeychainControllerImpl: CredentialKeychainController {
    func deleteCredintals() {
        deleteCreditalsKeychainFacade.deleteCredintals(DeleteCredintalsKeychainRequest()) { [weak self] response in
            guard let self = self else { return }
            self.handleResult(response) { _ in
                print("Credintals successfully deleted")
            }
        }
    }
    
    func loadCredintals(_ completion: @escaping (Result<LoadCredintalsKeychainResponse>) -> Void) {
        loadCreditalsKeychainFacade.loadCredintals(LoadCredintalsKeychainRequest(), completion: completion)
    }
    
    func storeCredintals(_ credintals: String) {
        storeCreditalsKeychainFacade.storeCredintals(StoreCredintalsKeychainRequest(credentials: credintals)) { [weak self] response in
            guard let self = self else { return }
            self.handleResult(response) { _ in
                print("Credintals successfully stored")
            }
        }
    }
}
