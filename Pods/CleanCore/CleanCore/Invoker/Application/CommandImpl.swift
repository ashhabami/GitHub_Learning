//
//  CommandImpl.swift
//  Babylon
//
//  Created by Ondrej Fabian on 22/11/2015.
//  Copyright © 2015 Cleverlance. All rights reserved.
//

open class CommandImpl<Receiver: Interactor, Request, Response>: Command where Request == Receiver.Request, Response == Receiver.Response, Request: Equatable {

    public let receiver: Receiver
    public let request: Request
    public let completion: ValueBlock<Result<Response>>
    public let mutex: Mutex?

    public init(receiver: Receiver, request: Request, mutex: Mutex? = nil, completion: @escaping ValueBlock<Result<Response>>) {
        self.receiver = receiver
        self.request = request
        self.completion = completion
        self.mutex = mutex
    }

    open func execute() throws -> Response {
        return try receiver.execute(request)
    }

    open func complete(_ result: Result<Response>) {
        completion(result)
    }
}
