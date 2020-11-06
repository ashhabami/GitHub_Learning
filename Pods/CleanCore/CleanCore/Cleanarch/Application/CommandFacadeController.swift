//
//  CommandFacadeController.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 10/01/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

open class CommandFacadeController<Facade, Response>: BaseControllerImpl {
    private let facade: Facade
    private var storage: Response?

    public init(facade: Facade) {
        self.facade = facade
        super.init()
    }

    public func start() {
        loading = true
        notifyListenersAboutUpdate()
        startFacade(facade: facade) { [weak self] result in
            self?.handleResult(result)
        }
    }

    /**
     Do not call this method.
     Must be overwriten.
     In this method facade is started. As response should be used responseBlock.
     - parameter facade: Facade given in init
     - parameter responseBlock: This block handles the facade response
     ### Usage Example: ###
     ```
     func startFacade(facade: Facade, responseBlock: @escaping (Result<Response>) -> Void) {
        facade.execute(request: request, responseBlock: responseBlock)
     }
     ```
     */
    open func startFacade(facade: Facade, responseBlock: @escaping (Result<Response>) -> Void) {
        fatalError("Method func startFacade(facade: Facade, responseBlock: @escaping (Result<Response>) -> Void) must be overwritten. More in method help.")
    }

    private func handleResult(_ result: Result<Response>) {
        loading = false
        handleResult(result, success: { [weak self] response in
            self?.handle(response)
        })
    }

    private func handle(_ response: Response) {
        storage = response
        notifyListenersAboutUpdate()
    }

    public func getResponse() -> Response? {
        return storage
    }

    public func resetResponse() {
        storage = nil
    }
}
