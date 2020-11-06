//
//  ScopeService.swift
//  Cleancore
//
//  Created by Ondrej Fabian on 27/10/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

public enum ScopeServiceError: Error {
    case missingScopeSpec
    case incorrectStartData
    case parentNotFound
    case serviceNotRegistered
}

public protocol ScopeService {
    func start(scope: Scope, with data: Any, parent: Scope) throws
    func discard(scope: Scope)
}
