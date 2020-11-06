//
//  ScopedInstanceProvider.swift
//  CleanPlatform
//
//  Created by Ondrej Fabian on 30/10/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import CleanCore

public protocol ScopedInstanceProvider {
    func getInstance<T>(_ type: T.Type, scope: Scope) throws -> T
    func getInstance<T, A>(_ type: T.Type, scope: Scope, argument: A) throws -> T
}
