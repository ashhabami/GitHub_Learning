//
//  Parser.swift
//  Babylon
//
//  Created by Libor Huspenina on 15/12/2015.
//  Copyright © 2015 Cleverlance. All rights reserved.
//

open class Parser {

    let primitiveTypeExtractor: PrimitiveTypeExtractor
    public var deserializedBody: DeserializedBody?

    public init(primitiveTypeExtractor: PrimitiveTypeExtractor) {
        self.primitiveTypeExtractor = primitiveTypeExtractor
    }

    public func getValueFromOptional<Value>(_ optional: Value?) throws -> Value {
        return try optional ?! ResourceError.incorrectResponse
    }

    // MARK: - Values extraction

    public func getValue<ReturnValue>(_ type: ReturnValue.Type, forKey key: String) throws -> ReturnValue {
        let body = try unwrappedBody()
        return try getValueFromDictonary(body, type: type, forKey: key)
    }

    public func getOptional<ReturnValue>(_ type: ReturnValue.Type, forKey key: String) throws -> ReturnValue? {
        let body = try unwrappedBody()
        return try getOptionalFromDictionary(body, type: type, forKey: key)
    }

    public func getValueFromDictonary<ReturnValue>(_ dict: [String: Any], type: ReturnValue.Type, forKey key: String) throws -> ReturnValue {
        guard let value = dict[key] else {
            logWarning("No value found for key: \(key) in: \(dict)", domain: .network)
            throw ResourceError.incorrectResponse
        }
        return try extractValue(value, type: type)
    }

    public func getOptionalFromDictionary<ReturnValue>(_ dict: [String: Any], type: ReturnValue.Type, forKey key: String) throws -> ReturnValue? {
        guard let value = dict[key] else {
            return nil
        }

        if primitiveTypeExtractor.isNull(value) {
            return nil
        }

        return try extractValue(value, type: type)
    }

    // MARK: - Private
    private func unwrappedBody() throws -> [String: Any] {
        return try deserializedBody as? [String: Any] ?! ResourceError.incorrectResponse
    }

    private func extractValue<ReturnValue>(_ value: Any, type: ReturnValue.Type) throws -> ReturnValue {
        guard let extractedValue = primitiveTypeExtractor.extractType(value, type: type) else {
            logWarning("Could not extract type '\(type)' from '\(value)'", domain: .network)
            throw ResourceError.incorrectResponse
        }
        return extractedValue
    }
}
