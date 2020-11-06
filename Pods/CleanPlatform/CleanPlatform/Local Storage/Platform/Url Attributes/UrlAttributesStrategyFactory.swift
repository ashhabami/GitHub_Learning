//
//  UrlAttributesStrategyFactory.swift
//  CleanCore
//
//  Created by Jan Halousek on 05/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

public protocol UrlAttributesStrategyFactory {
    func makeStrategy(isBackupable: Bool, isUsingDataProtection: Bool) -> UrlAttributesStrategy
}
