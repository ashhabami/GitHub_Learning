//
//  JSONResponseBodyDeserializationStrategy.swift
//  Creditas
//
//  Created by Ondrej Fabian on 21/01/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import Foundation
import CleanCore

public final class JSONResponseBodyDeserializationStrategy: ResponseBodyDeserializationStrategy {

    public init() { }

    public func deserialize(_ data: ResponseBody) throws -> DeserializedBody {
        do {
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as DeserializedBody
        } catch {
            logWarning(error)
            throw ResponseBodyDeserializationStrategyError.deserializationError
        }
    }
}
