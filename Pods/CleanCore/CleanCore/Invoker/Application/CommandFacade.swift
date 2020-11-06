//
//  Facade.swift
//  FMC
//
//  Created by Ondrej Fabian on 16/05/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

@available(*, deprecated, renamed: "CommandFacade")
protocol Facade: CommandFacade {
}

public protocol CommandFacade {
    associatedtype Request
    associatedtype Response

    func execute(_ request: Request, completion: @escaping (Result<Response>) -> Void)
}
