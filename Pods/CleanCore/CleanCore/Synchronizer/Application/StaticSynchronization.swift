//
//  StaticSynchronization.swift
//  cleancore
//
//  Created by Ondrej Fabian on 22/09/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

public func synchronize<ReturnType>(_ synchronizedBlock: @escaping () -> ReturnType) -> ReturnType {
    return SynchronizerHolder.synchronizer.synchronize(synchronizedBlock: synchronizedBlock)
}

public func synchronizeThrowing<ReturnType>(synchronizedBlock: @escaping () throws -> ReturnType) throws -> ReturnType {
    return try SynchronizerHolder.synchronizer.synchronizeThrowing(synchronizedBlock: synchronizedBlock)
}

public func setStaticSynchronizer(_ synchronizer: Synchronizer?) {
    SynchronizerHolder.synchronizer = synchronizer!
}

public final class SynchronizerHolder {
    static var synchronizer: Synchronizer!
}
