//
//  Command.swift
//  FMC
//
//  Created by Ondrej Fabian on 16/05/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public protocol Command: CustomStringConvertible, Equatable, Mutexable {
    associatedtype Receiver
    associatedtype Request
    associatedtype Response

    var receiver: Receiver { get }
    var request: Request { get }
    var completion: ValueBlock<Result<Response>> { get }

    func execute() throws -> Response
    func complete(_ result: Result<Response>)
}

extension Command {
    public var description: String {
        return "\(String(describing: type(of: self))) \(String(describing: request))"
    }
}

public func ==<CommandType: Command> (lhs: CommandType, rhs: CommandType) -> Bool where CommandType.Receiver: Equatable, CommandType.Request: Equatable {
    let receiverEqual = lhs.receiver == rhs.receiver
    let requestEqual = lhs.request == rhs.request
    return receiverEqual && requestEqual
}
