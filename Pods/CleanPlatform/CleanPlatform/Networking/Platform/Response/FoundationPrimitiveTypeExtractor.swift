//
//  FoundationPrimitiveTypeExtractor.swift
//  Babylon
//
//  Created by Ondrej Fabian on 07/01/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import Foundation
import CleanCore

public final class FoundationPrimitiveTypeExtractor: PrimitiveTypeExtractor {

    public init() { }

    public func extractType<ReturnValue>(_ value: Any, type: ReturnValue.Type) -> ReturnValue? {

        if let value = value as? NSNumber {
            switch type {
            case is Int.Type:
                return value.intValue as? ReturnValue
            case is Double.Type:
                return value.doubleValue as? ReturnValue
            case is String.Type:
                return value.stringValue as? ReturnValue
            default:
                return value as? ReturnValue
            }
        } else if let value = value as? String {
            switch type {
            case is Int.Type:
                return Int(value) as? ReturnValue
            case is Double.Type:
                return Double(value) as? ReturnValue
            default:
                return value as? ReturnValue
            }
        }

        return value as? ReturnValue
    }

    public func isNull(_ value: Any) -> Bool {
        return value is NSNull
    }
}
