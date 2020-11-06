//
//  SynchronizerImpl.swift
//  FMC
//
//  Created by Ondrej Fabian on 13/04/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import CleanCore
import Foundation

public class SynchronizerImpl: Synchronizer {

    private static let lock: NSString = "synchronizedQueue"

    public init() { }

    public func synchronize<ReturnType>(synchronizedBlock: @escaping () -> ReturnType) -> ReturnType {
        objc_sync_enter(SynchronizerImpl.lock)
        defer { objc_sync_exit(SynchronizerImpl.lock) }
        return synchronizedBlock()
    }

    public func synchronizeThrowing<ReturnType>(synchronizedBlock: @escaping () throws -> ReturnType) throws -> ReturnType {
        objc_sync_enter(SynchronizerImpl.lock)
        defer { objc_sync_exit(SynchronizerImpl.lock) }
        return try synchronizedBlock()
    }
}
