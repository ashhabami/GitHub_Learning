//
//  LocalStorage.swift
//  FMC
//
//  Created by Ondrej Fabian on 18/08/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public enum LocalStorageError: Error, Equatable {
    case storeFailed(String)
    case loadFailed(String)
    case deleteFailed(String)

    public static func ==(lhsError: LocalStorageError?, rhs: LocalStorageError) -> Bool {
        guard let lhs = lhsError else {
            return false
        }
        switch (lhs, rhs) {
        case (.storeFailed(let lhsString), .storeFailed(let rhsString)):
            return lhsString == rhsString
        case (.loadFailed(let lhsString), .loadFailed(let rhsString)):
            return lhsString == rhsString
        case (.deleteFailed(let lhsString), .deleteFailed(let rhsString)):
            return lhsString == rhsString
        default:
            return false
        }
    }
}

public protocol LocalStorage {
    func storeData(_ type: String, id: String, data: Bytes) throws
    func loadData(_ type: String, id: String) throws -> Bytes
    func deleteData(_ type: String, id: String) throws
}

public extension LocalStorage {
    private var settingType: String {
        return "notype"
    }

    func storeSetting(_ key: String, value: String) {
        let bytes: Bytes = toByteArray(value)
        _ = try? storeData(settingType, id: key, data: bytes)
    }

    func storeSetting(_ key: String, value: Bool) {
        let bytes: Bytes = toByteArray(value)
        _ = try? storeData(settingType, id: key, data: bytes)
    }

    func storeSetting(_ key: String, value: Double) {
        let bytes: Bytes = toByteArray(value)
        _ = try? storeData(settingType, id: key, data: bytes)
    }

    func storeSetting(_ key: String, value: Int) {
        let bytes: Bytes = toByteArray(value)
        _ = try? storeData(settingType, id: key, data: bytes)
    }

    func loadSetting<Type>(_ key: String) throws -> Type {
        let data = try loadData(settingType, id: key)
        return try fromByteArray(data, Type.self)
    }

    func deleteSetting(_ key: String) {
        try? deleteData(settingType, id: key)
    }

    private func toByteArray<T>(_ value: T) -> Bytes {
        var value = value
        return withUnsafeBytes(of: &value) { Array($0) }
    }

    private func fromByteArray<T>(_ value: Bytes, _ type: T.Type) throws -> T {
        return try value.withUnsafeBytes {
            guard let baseAddress = $0.baseAddress else { throw LocalStorageError.loadFailed("\(#function)") }
            return baseAddress.load(as: type)
        }
    }
}
