//
//  EmptyAssembly.swift
//  CleanPlatform
//
//  Created by Ondrej Fabian on 31/10/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import Swinject

public class EmptyAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) { }
}
