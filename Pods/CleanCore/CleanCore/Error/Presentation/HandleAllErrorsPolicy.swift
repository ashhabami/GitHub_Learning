//
//  HandleAllErrorsPolicy.swift
//  CleanCore
//
//  Created by Libor Huspenina on 22/03/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

public final class HandleAllErrorsPolicy: ErrorHandlingPolicy {

    public init() { }

    public func isHandlable(error: Error) -> Bool {
        return true
    }
}
