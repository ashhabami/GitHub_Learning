//
//  UserDefaultsStorageImpl.swift
//  FMC
//
//  Created by Ondrej Fabian on 28/06/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import Foundation
import CleanCore

public final class UserDefaultsStorageImpl: LocalStorage {

    public init() { }

    public func storeData(_ type: String, id: String, data: Bytes) throws {
        let key = composeKeyFromType(type, id: id)
        logDebug("Storing user defaults record with key: \(key)", domain: .storage)
        try throwErrorIfParamsAreEmpty(type, id: id, error: LocalStorageError.storeFailed("Invalid storage parameters type:'\(type)' id:'\(id)'"))
        UserDefaults.standard.set(Data(data), forKey: key)
    }

    public func loadData(_ type: String, id: String) throws -> Bytes {
        try throwErrorIfParamsAreEmpty(type, id: id, error: LocalStorageError.loadFailed("Invalid storage parameters type:'\(type)' id:'\(id)'"))
        let key = composeKeyFromType(type, id: id)
        guard let data: Data = UserDefaults.standard.value(forKey: key) as? Data else {
            logWarning("No data found in the user defaults for the key: '\(key)'", domain: .storage)
            throw LocalStorageError.loadFailed("")
        }
        return data.toArrayOfInts()
    }

    public func deleteData(_ type: String, id: String) throws {
        let key = composeKeyFromType(type, id: id)
        logDebug("Deleting user defaults record with key: \(key)", domain: .storage)
        try throwErrorIfParamsAreEmpty(type, id: id, error: LocalStorageError.deleteFailed("Invalid storage parameters type:'\(type)' id:'\(id)'"))
        UserDefaults.standard.removeObject(forKey: key)
    }
}
