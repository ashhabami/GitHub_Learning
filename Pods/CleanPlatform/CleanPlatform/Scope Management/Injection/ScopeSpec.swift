//
//  ScopeSpec.swift
//  FMC
//
//  Created by Ondrej Fabian on 02/06/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import Swinject

public protocol ScopeSpec {
    func assemblies() -> [Assembly]
    func start(_ data: Any) throws -> Assembly
}
