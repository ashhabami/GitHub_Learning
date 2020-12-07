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
    private let type = "credentials"
    
    init(
        keychain: LocalStorage
    ) {
        self.keychain = keychain
    }
    
    func storeCredentials(_ credentials: String) throws {
        let data = Bytes(credentials.utf8)
        try keychain.storeData(type, id: id, data: data)
    }
    
    func loadCredentials() throws -> String {
        let data = try keychain.loadData(type, id: id)
        guard let credentials = String(bytes: data, encoding: .utf8) else {
            throw LocalStorageError.loadFailed("String to Data convertion failed")
        }
        return credentials
    }
    
    func deleteCredentials() throws {
        try keychain.deleteData(type, id: id)
    }
}
