//
//  LocalStorageFactoryImpl.swift
//  CleanCore
//
//  Created by Jan Halousek on 05/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import CleanCore
import KeychainAccess

public final class LocalStorageFactoryImpl: LocalStorageFactory {

    public func makeUserDefaultsStorage() -> LocalStorage {
        return UserDefaultsStorageImpl()
    }

    public func makeFileStorage(with configuration: FileStorageConfiguration) -> LocalStorage {
        let attributesStrategy = makeAttributesStrategy(with: configuration)
        let pathResolver = makePathResolver(with: configuration)
        return FileStorage(attributesStrategy: attributesStrategy, basePathResolver: pathResolver)
    }

    public func makeKeychainStorage(with configuration: KeychainConfiguration) -> LocalStorage {
        switch configuration.deleteWithApp {
        case .no:
            return makeDefaultKeychainStorage(with: configuration)
        case .yesWithDefaultConfiguration:
            let fileConfiguration = FileStorageConfiguration()
            return makeInstallationKeychainStorage(fileStorageConfiguration: fileConfiguration, keychainConfiguration: configuration)
        case let .yes(fileConfiguration):
            return makeInstallationKeychainStorage(fileStorageConfiguration: fileConfiguration, keychainConfiguration: configuration)
        }
    }

    // MARK: - File storage

    private func makeAttributesStrategy(with configuration: FileStorageConfiguration) -> UrlAttributesStrategy {
        let strategyFactory = UrlAttributesStrategyFactoryImpl()
        return strategyFactory.makeStrategy(isBackupable: configuration.isBackupable, isUsingDataProtection: configuration.isProtected)
    }

    private func makePathResolver(with configuration: FileStorageConfiguration) -> FileStoragePathResolver {
        if let groupIdentifier = configuration.sharedGroupIdentifier {
            return FileStorageSharedPathResolver(groupIdentifier: groupIdentifier)
        } else {
            return FileDocumentsPathResolver()
        }
    }

    // MARK: - Keychain

    private func makeDefaultKeychainStorage(with configuration: KeychainConfiguration) -> LocalStorage {
        let keychain = makeKeychain(with: configuration.accessGroup)
            .synchronizable(configuration.isSynchronizable)
            .accessibility(.always)
        return KeychainStorage(keychain: keychain)
    }

    private func makeKeychain(with accessGroup: String?) -> Keychain {
        if let accessGroup = accessGroup {
            return Keychain(service: KeychainStorage.keychainServiceName, accessGroup: accessGroup)
        } else {
            return Keychain(service: KeychainStorage.keychainServiceName)
        }
    }

    // MARK: - Keychain Installation

    private func makeInstallationKeychainStorage(fileStorageConfiguration: FileStorageConfiguration, keychainConfiguration: KeychainConfiguration) -> LocalStorage {
        let installationPersistentStorage = makeFileStorage(with: fileStorageConfiguration)
        let lifetimePersistentStorage = makeDefaultKeychainStorage(with: keychainConfiguration)
        return KeychainInstallationStorage(installationPersistentStorage: installationPersistentStorage, lifetimePersistentStorage: lifetimePersistentStorage)
    }
}
