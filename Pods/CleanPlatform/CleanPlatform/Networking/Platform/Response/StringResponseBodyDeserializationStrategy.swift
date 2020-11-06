//
//  StringResponseBodyDeserializationStrategy.swift
//  Creditas
//
//  Created by Ondrej Fabian on 21/01/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import Foundation
import CleanCore

public final class StringResponseBodyDeserializationStrategy: ResponseBodyDeserializationStrategy {

    public init() { }

    public func deserialize(_ data: ResponseBody) throws -> DeserializedBody {
        guard let body = String(data: data, encoding: .utf8) else {
            logWarning("Error while converting Unicode string.", domain: .network)
            throw ResponseBodyDeserializationStrategyError.deserializationError
        }

        logInfo("Serialized: \(body)", domain: .network)
        return body
    }
}
