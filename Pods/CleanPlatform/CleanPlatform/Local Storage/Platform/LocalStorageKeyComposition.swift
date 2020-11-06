//
//  LocalStorageKeyComposition.swift
//  CleanPlatform
//
//  Created by Ondrej Fabian on 01/11/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import CleanCore

public extension LocalStorage {
    func composeKeyFromType(_ type: String, id: String) -> String {
        return "\(type)_\(id)"
    }

    func throwErrorIfParamsAreEmpty(_ type: String, id: String, error: LocalStorageError) throws {
        if type.isEmpty || id.isEmpty {
            logWarning("Invalid storage parameters type:'\(type)' id:'\(id)'", domain: .storage)
            throw error
        }
    }
}
