//
//  CredentialsKeychainStorage.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 04.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

typealias CredentialsKeychainResource = CredentialsKeychainService

class CredentialsKeychainResourceImpl: CredentialsKeychainResource {
    
    private let keychain: LocalStorage
    private let id = "Keychain"
    private let type = "credintals"
    
    init(
        keychain: LocalStorage
    ) {
        self.keychain = keychain
    }
    
    func storeCredentials(_ credintails: String) throws {
        let data = Bytes(credintails.utf8)
        try keychain.storeData(type, id: id, data: data)
    }
    
    func loadCredentials() throws -> String {
        let data = try keychain.loadData(type, id: id)
        guard let credintals = String(bytes: data, encoding: .utf8) else {
            throw LocalStorageError.loadFailed("String to Data convertion failed")
        }
        return credintals
    }
    
    func deleteCredentials() throws {
        try keychain.deleteData(type, id: id)
    }
}
