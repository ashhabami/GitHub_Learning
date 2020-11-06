//
//  ErrorController.swift
//  FMC
//
//  Created by Ondrej Fabian on 25/07/16.
//  Copyright (c) 2016 Cleverlance. All rights reserved.
//

public protocol ErrorController: BaseController {
    func handleError(_ error: Error, displayableErrorConvertor: DisplayableErrorConvertor)
    func handleError(_ error: Error)
    func getError() -> Error?
    func getConvertor() -> DisplayableErrorConvertor?
    func finishHandling()
}

public final class ErrorControllerImpl: BaseControllerImpl, ErrorController {

    private var error: Error?
    private var displayableErrorConvertor: DisplayableErrorConvertor?

    public func handleError(_ error: Error) {
        handleErrorInternal(error, displayableErrorConvertor: nil)
    }

    public func handleError(_ error: Error, displayableErrorConvertor: DisplayableErrorConvertor) {
        handleErrorInternal(error, displayableErrorConvertor: displayableErrorConvertor)
    }

    public func getError() -> Error? {
        return error
    }

    public func getConvertor() -> DisplayableErrorConvertor? {
        return displayableErrorConvertor
    }

    public func finishHandling() {
        error = nil
        displayableErrorConvertor = nil
        notifyListenersAboutUpdate()
    }

    private func handleErrorInternal(_ error: Error, displayableErrorConvertor: DisplayableErrorConvertor?) {
        self.error = error
        self.displayableErrorConvertor = displayableErrorConvertor
        notifyListenersAboutUpdate()
    }
}
