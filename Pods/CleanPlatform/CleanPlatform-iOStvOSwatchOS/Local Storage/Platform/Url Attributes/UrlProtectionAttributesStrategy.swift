//
//  UrlProtectionAttributesStrategy.swift
//  CleanCore
//
//  Created by Jan Halousek on 05/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import Foundation

public final class UrlProtectionAttributesStrategy: UrlAttributesStrategy {
    
    private let isUsingDataProtection: Bool

    public init(isUsingDataProtection: Bool) {
        self.isUsingDataProtection = isUsingDataProtection
    }

    public func addAttributes(to url: URL) throws {
        if !isUsingDataProtection {
            var attributes = try FileManager.default.attributesOfItem(atPath: url.path)
            attributes[.protectionKey] = FileProtectionType.none
            try FileManager.default.setAttributes(attributes, ofItemAtPath: url.path)
        }
    }
}
