//
//  InstanceProvider.swift
//  FMC
//
//  Created by Ondrej Fabian on 07/06/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public protocol InstanceProvider: class {
    func getInstance<T>(_ type: T.Type) throws -> T
    func getInstance<T, A>(_ type: T.Type, argument: A) throws -> T
}
