//
//  ResponseBodyDeserializationStrategyAssembly.swift
//  CleanCore
//
//  Created by Libor Huspenina on 03/07/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

public struct ResponseBodyDeserializationStrategyType {
    public static let string = "string"
    public static let json = "json"
}

public final class ResponseBodyDeserializationStrategyAssembly: Assembly {

    public func assemble(container: Container) {

        container.register(ResponseBodyDeserializationStrategy.self) { r in
            return r.resolve(ResponseBodyDeserializationStrategy.self, name: ResponseBodyDeserializationStrategyType.json)!
        }

        container.register(ResponseBodyDeserializationStrategy.self, name: ResponseBodyDeserializationStrategyType.json) { _ in
            return JSONResponseBodyDeserializationStrategy()
        }

        container.register(ResponseBodyDeserializationStrategy.self, name: ResponseBodyDeserializationStrategyType.string) { _ in
            return StringResponseBodyDeserializationStrategy()
        }
    }
}
