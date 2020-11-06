//
//  FileStorageSharedPathResolver.swift
//  CleanCore
//
//  Created by Jan Halousek on 24/01/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import CleanCore
import Foundation

public class FileStorageSharedPathResolver: FileStoragePathResolver {
    
    private let groupIdentifier: String

    public init(groupIdentifier: String) {
        self.groupIdentifier = groupIdentifier
    }
    
    public func getBasePath() -> String? {
        let fileManager = FileManager.default
        let containerUrl = fileManager.containerURL(forSecurityApplicationGroupIdentifier: groupIdentifier)
        if containerUrl?.path == nil {
            logWarning("No container URL returned from: containerURL(forSecurityApplicationGroupIdentifier: \(groupIdentifier))", domain: .storage)
        }
        return containerUrl?.path
    }
}
