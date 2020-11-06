//
//  CodingSerializer.swift
//  FMC
//
//  Created by Tomas Sliz on 27/09/2016.
//  Copyright © 2016 Cleverlance. All rights reserved.
//
// swiftlint:disable force_cast

import Foundation
import CleanCore

public protocol Wrappable {
    func wrapper() -> Wrapper
}

public protocol Wrapper {
    func unwrap<ObjType>() throws -> ObjType
}

open class WrapperImpl: NSObject, Wrapper {

    public let wrappedObject: Any

    public init(wrappedObject: Any) {
        self.wrappedObject = wrappedObject
    }

    public func unwrap<WrappedType>() throws -> WrappedType {
        let object = try wrappedObject as? WrappedType ?! SerializerError.unableToDeserialize
        return object
    }
}

public class CodingSerializer: Serializer {

    public init() { }

    public func serialize<Type>(_ object: Type) throws -> Bytes {
        guard let wrappable = object as? Wrappable else {
            logWarning("Object \(object) does not conform to protocol 'Wrappable'")
            throw SerializerError.unableToSerialize
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: wrappable.wrapper())
        let bytes = data.toArrayOfInts()
        return bytes
    }

    public func deserialize<Type>(_ data: Bytes) throws -> Type {
        let systemData = Data(data: data)
        do {
            let unarchivedObj = NSKeyedUnarchiver.unarchiveObject(with: systemData)
            let wrapper = unarchivedObj as? Wrapper
            let wrapperForSure = try wrapper ?! SerializerError.unableToDeserialize
            return try wrapperForSure.unwrap()
        } catch {
            logWarning(error)
            throw SerializerError.unableToDeserialize
        }

    }
}
