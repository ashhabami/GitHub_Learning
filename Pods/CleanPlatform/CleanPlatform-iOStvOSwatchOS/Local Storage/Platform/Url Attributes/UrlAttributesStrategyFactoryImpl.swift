//
//  UrlAttributesStrategyFactoryImpl.swift
//  CleanCore
//
//  Created by Jan Halousek on 05/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

public class UrlAttributesStrategyFactoryImpl: UrlAttributesStrategyFactory {

    public init() {}

    public func makeStrategy(isBackupable: Bool, isUsingDataProtection: Bool) -> UrlAttributesStrategy {
        return UrlAttributesStrategyComposite(strategies: [
            UrlBackupAttributesStrategy(isBackupable: isBackupable),
            UrlProtectionAttributesStrategy(isUsingDataProtection: isUsingDataProtection),
        ])
    }
}
