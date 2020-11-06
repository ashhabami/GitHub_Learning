//
//  ErrorHandler.swift
//  Babylon
//
//  Created by Ondrej Fabian on 04/01/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public protocol ErrorHandler {
    func handleError(_ error: Error, completion: @escaping BoolBlock)
}
