//
//  LocalStorageFactory.swift
//  CleanCore
//
//  Created by Jan Halousek on 05/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

public protocol LocalStorageFactory {
    func makeUserDefaultsStorage() -> LocalStorage
    func makeFileStorage(with configuration: FileStorageConfiguration) -> LocalStorage
    func makeKeychainStorage(with configuration: KeychainConfiguration) -> LocalStorage
}

public struct FileStorageConfiguration {
    public let isBackupable: Bool
    public let isProtected: Bool
    public let sharedGroupIdentifier: String?

    public init(isBackupable: Bool = true, isProtected: Bool = true, sharedGroupIdentifier: String? = nil) {
        self.isBackupable = isBackupable
        self.isProtected = isProtected
        self.sharedGroupIdentifier = sharedGroupIdentifier
    }
}

public struct KeychainConfiguration {
    public let isSynchronizable: Bool
    public let accessGroup: String?
    public let deleteWithApp: DeleteWithApp

    public init(isSynchronizable: Bool = false, accessGroup: String? = nil, deleteWithApp: DeleteWithApp = .no) {
        self.isSynchronizable = isSynchronizable
        self.accessGroup = accessGroup
        self.deleteWithApp = deleteWithApp
    }

    public enum DeleteWithApp {
        case no
        case yesWithDefaultConfiguration
        case yes(configuration: FileStorageConfiguration)
    }
}
