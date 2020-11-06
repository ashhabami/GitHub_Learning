//
//  FacadeImpl.swift
//  Babylon
//
//  Created by Ondrej Fabian on 22/11/2015.
//  Copyright © 2015 Cleverlance. All rights reserved.
//

@available(*, deprecated, renamed: "CommandFacadeImpl")
public typealias FacadeImpl = CommandFacadeImpl

open class CommandFacadeImpl<Receiver: Interactor, Request, Response>: CommandFacade where Request == Receiver.Request, Response == Receiver.Response, Request: Equatable {

    typealias FacadeCommand = CommandImpl<Receiver, Request, Response>

    let invoker: Invoker
    let receiver: Receiver
    let mutex: Mutex?

    public init(invoker: Invoker, receiver: Receiver, mutex: Mutex? = nil) {
        self.invoker = invoker
        self.receiver = receiver
        self.mutex = mutex
    }

    public func execute(_ request: Request, completion: @escaping (Result<Response>) -> Void) {
        let command = FacadeCommand(receiver: receiver, request: request, mutex: mutex, completion: completion)
        self.invoker.enqueueCommand(command)
    }
}
