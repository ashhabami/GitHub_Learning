//
//  Scope.swift
//  Cleancore
//
//  Created by Ondrej Fabian on 27/10/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

public typealias ScopeIdentifier = String

public enum ScopeInstanceIdentifier: Hashable {
    case single
    case multiple(identifier: ScopeIdentifier)

    public func hash(into hasher: inout Hasher) {
        switch self {
        case .single:
            hasher.combine(5381)
        case .multiple(let identifier):
            hasher.combine(identifier)
        }
    }

    public static func == (lhs: ScopeInstanceIdentifier, rhs: ScopeInstanceIdentifier) -> Bool {
        switch (lhs, rhs) {
        case (.single, .single):
            return true
        case (.multiple(let lhsIdentifier), .multiple(let rhsIdentifier)):
            return lhsIdentifier == rhsIdentifier
        default:
            return false
        }
    }
}

public enum ScopeFinishEvent {
    case notification
    case completion(Block)
}

open class Scope: Equatable, Hashable, CustomStringConvertible {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(instanceIdentifier())
        hasher.combine(typeIdentifier())
    }


    public init() { }

    open var description: String {
        return "\(typeIdentifier()) \(instanceIdentifier())"
    }

    open func finishEvent() -> ScopeFinishEvent {
        return .notification
    }

    open func instanceIdentifier() -> ScopeInstanceIdentifier {
        return .single
    }

    open func typeIdentifier() -> ScopeIdentifier {
        return String(describing: type(of: self))
    }

    public static func == (lhs: Scope, rhs: Scope) -> Bool {
        return lhs.instanceIdentifier() == rhs.instanceIdentifier() && lhs.typeIdentifier() == rhs.typeIdentifier()
    }
}
