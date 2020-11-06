//
//  UrlAttributesStrategyComposite.swift
//  CleanCore
//
//  Created by Jan Halousek on 05/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import Foundation

public final class UrlAttributesStrategyComposite: UrlAttributesStrategy {

    private let strategies: [UrlAttributesStrategy]

    public init(strategies: [UrlAttributesStrategy]) {
        self.strategies = strategies
    }

    public func addAttributes(to url: URL) throws {
        try strategies.forEach { try $0.addAttributes(to: url) }
    }
}
