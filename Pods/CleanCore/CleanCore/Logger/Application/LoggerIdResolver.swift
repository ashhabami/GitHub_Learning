//
//  LoggerIdResolver.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 09/11/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

public protocol LoggerIdResolver {
    func getId() -> LoggerId
    func getId(for object: AnyObject) -> LoggerId
}

final public class LoggerIdResolverImpl: LoggerIdResolver {
    
    private struct Id {
        weak var object: AnyObject?
        let id: LoggerId
    }
    
    private var counter = 0
    private var ids = [Id]()
    
    public init() {}
    
    public func getId() -> LoggerId {
        counter += 1
        return counter
    }
    
    public func getId(for object: AnyObject) -> LoggerId {
        removeObsoleteIds()
        
        if let id = ids.first(where: { $0.object === object }) {
            return id.id
        } else {
            let id = getId()
            ids.append(LoggerIdResolverImpl.Id(object: object, id: id))
            return id
        }
    }
    
    private func removeObsoleteIds() {
        ids = ids.filter({ $0.object !== nil })
    }
}
