//
//  InvokerConfiguration.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 24/08/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

public protocol InvokerConfiguration {
    func maximumCommands(for mutex: Mutex) -> UInt
}

public final class DefaultInvokerConfiguration: InvokerConfiguration {
    
    public init() {}

    public func maximumCommands(for mutex: Mutex) -> UInt {
        return 1
    }
}
