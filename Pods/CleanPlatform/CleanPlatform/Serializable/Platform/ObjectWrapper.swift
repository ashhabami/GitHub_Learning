//
//  ObjectWrapper.swift
//  FMC
//
//  Created by Libor Huspenina on 16/01/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import Foundation

public class ObjectToWrap {
    public let property: [String]

    public init (property: [String]) {
        self.property = property
    }
}

extension ObjectToWrap: Wrappable {
    public func wrapper() -> Wrapper {
        return ObjectToWrapWrapper(wrappedObject: self)
    }
}

open class ObjectToWrapWrapper: WrapperImpl, NSCoding {

    public required convenience init?(coder aDecoder: NSCoder) {
        guard let ids = aDecoder.decodeObject(forKey: "propertyKey") as? [String] else { return nil }
        let recordIds = ObjectToWrap(property: ids)
        self.init(wrappedObject: recordIds)
    }

    public func encode(with aCoder: NSCoder) {
        guard let wrappedObject: ObjectToWrap = try? unwrap() else { return }
        aCoder.encode(wrappedObject.property, forKey: "propertyKey")
    }
}
