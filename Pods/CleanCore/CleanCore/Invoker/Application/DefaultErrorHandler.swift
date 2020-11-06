//
//  AuthenticationErrorHandler.swift
//  Creditas
//
//  Created by Ondrej Fabian on 23/02/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public final class DefaultErrorHandler: ErrorHandler {

    public init() { }

    public func handleError(_ error: Error, completion: @escaping BoolBlock) {
        completion(false)
    }
}
