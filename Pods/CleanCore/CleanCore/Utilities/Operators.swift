//
//  or.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 28/02/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

infix operator ?!: NilCoalescingPrecedence
public func ?!<A>(lhs: A?, rhs: Error) throws -> A {
    guard let value = lhs else {
        throw rhs
    }
    return value
}
