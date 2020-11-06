//
//  Serializer.swift
//  FMC
//
//  Created by Tomas Sliz on 27/09/2016.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public enum SerializerError: Error {
    case unableToSerialize
    case unableToDeserialize
}

public protocol Serializer {
    func serialize<Type>(_ object: Type) throws -> Bytes
    func deserialize<Type>(_ data: Bytes) throws -> Type
}
