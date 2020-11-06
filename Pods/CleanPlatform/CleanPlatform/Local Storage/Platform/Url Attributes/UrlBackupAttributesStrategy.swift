//
//  UrlBackupAttributesStrategy.swift
//  CleanCore
//
//  Created by Jan Halousek on 05/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import Foundation

public final class UrlBackupAttributesStrategy: UrlAttributesStrategy {

    private let isBackupable: Bool

    public init(isBackupable: Bool) {
        self.isBackupable = isBackupable
    }

    public func addAttributes(to url: URL) throws {
        var url = url
        var values = URLResourceValues()
        values.isExcludedFromBackup = !isBackupable
        try url.setResourceValues(values)
    }
}
