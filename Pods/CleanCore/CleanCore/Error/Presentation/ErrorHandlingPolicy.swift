//
//  ErrorHandlingPolicy.swift
//  CleanCore
//
//  Created by Libor Huspenina on 22/03/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

public protocol ErrorHandlingPolicy {
    func isHandlable(error: Error) -> Bool
}
