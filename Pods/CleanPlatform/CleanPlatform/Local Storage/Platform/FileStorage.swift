//
//  FileStorage.swift
//  FMC
//
//  Created by Ondrej Fabian on 18/08/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import Foundation
import CleanCore

public class FileStorage: LocalStorage {
    private let attributesStrategy: UrlAttributesStrategy
    private let basePathResolver: FileStoragePathResolver

    public init(attributesStrategy: UrlAttributesStrategy, basePathResolver: FileStoragePathResolver) {
        self.attributesStrategy = attributesStrategy
        self.basePathResolver = basePathResolver
    }

    public func storeData(_ type: String, id: String, data: Bytes) throws {
        let path = getPathForRecord(type, id: id)
        logDebug("Storing file: \(String(describing: path))", domain: .storage)
        let filePath = try path ?! LocalStorageError.storeFailed("\(type)/\(id)")
        ensureDirectoryExists(filePath)
        try storeDataAtPath(filePath, data: data)
    }

    public func loadData(_ type: String, id: String) throws -> Bytes {
        let path = getPathForRecord(type, id: id)
        logDebug("Loading file: \(String(describing: path))", domain: .storage)
        let filePath = try path ?! LocalStorageError.loadFailed("\(type)/\(id)")
        return try loadDataFromPath(filePath)
    }

    public func deleteData(_ type: String, id: String) throws {
        let path = getPathForRecord(type, id: id)
        logDebug("Deleting file: \(String(describing: path))", domain: .storage)
        let filePath = try path ?! LocalStorageError.deleteFailed("\(type)/\(id)")
        try deleteDataAtPath(filePath)
    }

    private func getPathForEnclosingDirectory(_ type: String, id: String) -> String? {
        guard !type.isEmpty && !id.isEmpty else {
            logWarning("\(type)/\(id)", domain: .storage)
            return nil
        }

        let basePath = basePathResolver.getBasePath()

        guard let path = basePath else {
            logWarning("No base path", domain: .storage)
            return nil
        }

        return "\(path)/\(type)"
    }

    private func getPathForRecord(_ type: String, id: String) -> String? {
        if let path = getPathForEnclosingDirectory(type, id: id) {
            return "\(path)/\(id)"
        }

        return nil
    }

    private func storeDataAtPath(_ path: String, data: Bytes) throws {
        let systemData = Data(data)
        do {
            let url = URL(fileURLWithPath: path)
            try systemData.write(to: url, options: Data.WritingOptions.atomic)
            try attributesStrategy.addAttributes(to: url)
        } catch {
            logWarning(error, domain: .storage)
            throw LocalStorageError.storeFailed("\(error)")
        }
    }

    private func loadDataFromPath(_ path: String) throws -> Bytes {
        let url = URL(fileURLWithPath: path)
        let systemData: Data
        do {
            systemData = try Data(contentsOf: url)
        } catch {
            logWarning("Data at path can not be decoded: \(path)", domain: .storage)
            throw LocalStorageError.loadFailed("\(error)")
        }
        return systemData.toArrayOfInts()
    }

    private func deleteDataAtPath(_ path: String) throws {
        let fileManager = FileManager.default

        do {
            if fileManager.fileExists(atPath: path) {
                try fileManager.removeItem(atPath: path)
            }
        } catch {
            logWarning(error, domain: .storage)
            throw LocalStorageError.deleteFailed("\(error)")
        }
    }

    private func ensureDirectoryExists(_ path: String) {
        let dirPath = path.components(separatedBy: "/").dropLast().joined(separator: "/")
        do {
            try FileManager.default.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
        } catch {
            logWarning(error, domain: .storage)
        }
    }
}
