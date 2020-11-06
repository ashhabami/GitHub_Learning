//
//  KeychainInstallationStorage.swift
//  FMC
//
//  Created by Vít Míchal on 16.11.16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import KeychainAccess
import CleanCore

public final class KeychainInstallationStorage: LocalStorage {

    private let lifetimePersistentStorage: LocalStorage
    private let installationPersistentStorage: LocalStorage
    public let dummyData: Bytes = []

    public init(installationPersistentStorage: LocalStorage, lifetimePersistentStorage: LocalStorage) {
        self.lifetimePersistentStorage = lifetimePersistentStorage
        self.installationPersistentStorage = installationPersistentStorage
    }

    public func storeData(_ type: String, id: String, data: Bytes) throws {
        do {
            try lifetimePersistentStorage.storeData(type, id: id, data: data)
            try installationPersistentStorage.storeData(type, id: id, data: dummyData)
        } catch {
            logWarning(error, domain: .storage)
            throw LocalStorageError.storeFailed("\(error)")
        }
    }

    public func loadData(_ type: String, id: String) throws -> Bytes {
        do {
            _ = try installationPersistentStorage.loadData(type, id: id)
            return try lifetimePersistentStorage.loadData(type, id: id)
        } catch {
            logWarning(error, domain: .storage)
            try lifetimePersistentStorage.deleteData(type, id: id)
            throw LocalStorageError.loadFailed("\(error)")
        }
    }

    public func deleteData(_ type: String, id: String) throws {
        do {
            try lifetimePersistentStorage.deleteData(type, id: id)
            try installationPersistentStorage.deleteData(type, id: id)
        } catch {
            logWarning(error, domain: .storage)
            throw LocalStorageError.deleteFailed("\(error)")
        }
    }
}
