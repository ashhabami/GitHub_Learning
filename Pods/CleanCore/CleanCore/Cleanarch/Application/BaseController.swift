//
//  BaseController.swift
//  FMC
//
//  Created by Ondrej Fabian on 01/07/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public protocol Listener: class { }

public typealias UpdateBlock = ValueBlock<AnyObject>
public typealias ErrorBlock = ValueBlock<AnyObject>

public protocol BaseController: class {
    var lastError: Error? { get }

    func isLoading() -> Bool
    func subscribe(_ listener: Listener, errorBlock: ErrorBlock?, updateBlock: UpdateBlock?)
    func unsubscribe(_ listenerToBeRemoved: Listener)
    func numberOfSubscribers() -> Int
}

private struct Subscription {
    weak var listener: Listener?
    let update: UpdateBlock?
    let error: ErrorBlock?
}

open class BaseControllerImpl: BaseController {

    public var lastError: Error?
    public var loading: Bool

    private var subscriptions: [Subscription] = []

    public init() {
        loading = false
    }

    open func isLoading() -> Bool {
        return loading
    }

    open func subscribe(_ listener: Listener, errorBlock: ErrorBlock?, updateBlock: UpdateBlock?) {
        unsubscribe(listener)

        if errorBlock != nil || updateBlock != nil {
            let subscription = Subscription(listener: listener, update: updateBlock, error: errorBlock)
            synchronize { [weak self] in
                self?.subscriptions.append(subscription)
            }
        }
    }

    public func numberOfSubscribers() -> Int {
        return subscriptions.count
    }

    public func unsubscribe(_ listenerToBeRemoved: Listener) {
        synchronize { [weak self] in
            if let welf = self {
                welf.subscriptions = welf.subscriptions.filter { subscription in
                    return ((listenerToBeRemoved as AnyObject) !== (subscription.listener as AnyObject))
                }
            }
        }
    }

    public func notifyListenersAboutUpdate() {
        removeDeadListeners()
        synchronize { [weak self] in
            if let welf = self {
                welf.subscriptions.forEach { $0.update?(welf) }
            }
        }
    }

    public func notifyListeners(about error: Error) {
        logWarning(error)
        lastError = error
        notifyListenersAboutError()
        lastError = nil
    }

    public func handleResult<Response>(_ result: Result<Response>, success: ValueBlock<Response>) {
        switch result {
        case .success(let response):
            success(response)
        case .failure(let error):
            notifyListeners(about: error)
        }
    }

    public func notifyListenersAboutError() {
        removeDeadListeners()
        synchronize { [weak self] in
            if let welf = self {
                welf.subscriptions.forEach { $0.error?(welf) }
            }
        }
    }

    private func removeDeadListeners() {
        synchronize { [weak self] in
            if let welf = self {
                welf.subscriptions = welf.subscriptions.filter { lnb in
                    return lnb.listener != nil
                }
            }
        }
    }

    public func executeFacade<Response>(executeBlock: (_ responseBlock: @escaping (Result<Response>) -> Void) -> Void, responseBlock: @escaping (Response) -> Void) {
        loading = true
        notifyListenersAboutUpdate()

        let handleBlock: ((Result<Response>) -> Void) = { [weak self] result in
            self?.handleResponse(result, responseBlock: responseBlock)
        }

        executeBlock(handleBlock)
    }

    public func handleResponse<Response>(_ result: Result<Response>, responseBlock: @escaping (Response) -> Void) {
        loading = false
        handleResult(result, success: { [weak self] response in
            self?.handle(response, responseBlock: responseBlock)
        })
    }

    private func handle<Response>(_ response: Response, responseBlock: @escaping (Response) -> Void) {
        responseBlock(response)
        notifyListenersAboutUpdate()
    }
}
