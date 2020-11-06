//
//  ResponseBodyDeserializationStrategy.swift
//  Creditas
//
//  Created by Ondrej Fabian on 10/12/15.
//  Copyright © 2015 Cleverlance. All rights reserved.
//

import Foundation

@available(*, deprecated, renamed: "DeserializedBody")
public typealias ResponseObjectBody = DeserializedBody
public typealias DeserializedBody = Any

public enum ResponseBodyDeserializationStrategyError: Error {
    case deserializationError
}

public protocol ResponseBodyDeserializationStrategy {
    func deserialize(_ data: ResponseBody) throws -> DeserializedBody
}
