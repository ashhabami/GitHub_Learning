//
//  Synchronizer.swift
//  FMC
//
//  Created by Ondrej Fabian on 13/04/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

public protocol Synchronizer {
    func synchronize<ReturnType>(synchronizedBlock: @escaping () -> ReturnType) -> ReturnType
    func synchronizeThrowing<ReturnType>(synchronizedBlock: @escaping () throws -> ReturnType) throws -> ReturnType
}
