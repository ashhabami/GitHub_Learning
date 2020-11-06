//
//  ScopeSpecProvider.swift
//  CleanPlatform
//
//  Created by Ondrej Fabian on 30/10/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import CleanCore

public protocol ScopeSpecProvider {
    func spec(describing scope: Scope) -> ScopeSpec?
}
