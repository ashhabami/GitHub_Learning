//
//  ResourceError.swift
//  Babylon
//
//  Created by Ondrej Fabian on 11/12/15.
//  Copyright © 2015 Cleverlance. All rights reserved.
//

public struct BusinessError: Error, Equatable {
    public let code: Int
    public let error: String
    public let description: String

    public init(code: Int, error: String, description: String) {
        self.code = code
        self.error = error
        self.description = description
    }

    public static func == (lhs: BusinessError, rhs: BusinessError) -> Bool {
        return lhs.code == rhs.code && lhs.error == rhs.error
    }
}

public enum ResourceError: Error, Equatable {
    case remoteResource
    case incorrectResponse
    case business(businessError: BusinessError)
    case requestCreation
    case authentication
    case server
    case client

    public static func == (lhs: ResourceError, rhs: ResourceError) -> Bool {
        switch (lhs, rhs) {
        case (.remoteResource, .remoteResource): fallthrough
        case (.incorrectResponse, .incorrectResponse): fallthrough
        case (.requestCreation, .requestCreation): fallthrough
        case (.authentication, .authentication): fallthrough
        case (.server, .server): return true
        case (.client, .client): return true
        case (.business(let lhsBusinessError), .business(let rhsBusinessError)):
            return lhsBusinessError == rhsBusinessError
        default: return false
        }
    }
}
