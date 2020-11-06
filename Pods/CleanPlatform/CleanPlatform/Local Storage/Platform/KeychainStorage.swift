//
//  KeychainStorage.swift
//  FMC
//
//  Created by Tomas Sliz on 26/09/2016.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import KeychainAccess
import CleanCore

open class KeychainStorage: LocalStorage {

    static let keychainServiceName = "com.cleverlance.core"
    private let keychain: Keychain

    public init(keychain: Keychain? = nil) {
        self.keychain = keychain ?? Keychain(service: KeychainStorage.keychainServiceName).synchronizable(false).accessibility(.always)
    }

    public func storeData(_ type: String, id: String, data: Bytes) throws {
        let key = composeKeyFromType(type, id: id)

        logDebug("Storing keychain record with key: \(key)", domain: .storage)

        try throwErrorIfParamsAreEmpty(type, id: id, error: LocalStorageError.storeFailed("\(type)/\(id)"))

        do {
            try keychain.set(Data(data), key: key)
        } catch {
            logWarning(error, domain: .storage)
            throw LocalStorageError.storeFailed("\(error)")
        }
    }

    public func loadData(_ type: String, id: String) throws -> Bytes {
        let keychainData: Data?
        let key = composeKeyFromType(type, id: id)

        logDebug("Loading keychain record with key: \(key)", domain: .storage)

        try throwErrorIfParamsAreEmpty(type, id: id, error: LocalStorageError.loadFailed("\(type)/\(id)"))

        do {
            keychainData = try keychain.getData(key)
        } catch {
            logWarning(error)
            throw LocalStorageError.loadFailed("\(error)")
        }

        guard let data = keychainData?.toArrayOfInts() else {
            logWarning("No data found in the keychain for the key: '\(composeKeyFromType(type, id: id))'", domain: .storage)
            throw LocalStorageError.loadFailed("\(type)/\(id)")
        }

        return data
    }

    public func deleteData(_ type: String, id: String) throws {
        let key = composeKeyFromType(type, id: id)

        logDebug("Deleting keychain record with key: \(key)", domain: .storage)

        try throwErrorIfParamsAreEmpty(type, id: id, error: LocalStorageError.deleteFailed("\(type)/\(id)"))

        do {
            try keychain.remove(key)
        } catch {
            logWarning(error)
            throw LocalStorageError.deleteFailed("\(error)")
        }
    }
}
