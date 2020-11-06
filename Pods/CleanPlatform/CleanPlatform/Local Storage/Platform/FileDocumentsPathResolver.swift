//
//  FileDocumentsPathResolver.swift
//  CleanCore
//
//  Created by Jan Halousek on 24/01/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import CleanCore
import Foundation

public class FileDocumentsPathResolver: FileStoragePathResolver {
    public init() {}

    public func getBasePath() -> String? {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        if path == nil {
            logWarning("No path for: NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)", domain: .storage)
        }
        return path
    }
}
