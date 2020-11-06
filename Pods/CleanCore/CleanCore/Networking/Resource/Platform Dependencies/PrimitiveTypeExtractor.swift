//
//  PrimitiveTypeExtractor.swift
//  Babylon
//
//  Created by Ondrej Fabian on 07/01/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public protocol PrimitiveTypeExtractor {
    func extractType<ReturnValue>(_ value: Any, type: ReturnValue.Type) -> ReturnValue?
    func isNull(_ value: Any) -> Bool
}
