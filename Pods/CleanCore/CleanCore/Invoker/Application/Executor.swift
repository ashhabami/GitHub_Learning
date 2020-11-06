//
//  Executor.swift
//  Babylon
//
//  Created by Ondrej Fabian on 22/11/2015.
//  Copyright © 2015 Cleverlance. All rights reserved.
//

public protocol Executor {
    func executeCommand<CommandType: Command>(_ command: CommandType, completion: @escaping (Result<CommandType.Response>) -> Void)
}
