//
//  ErrorPresenter.swift
//  FMC
//
//  Created by Ondrej Fabian on 25/07/16.
//  Copyright (c) 2016 Cleverlance. All rights reserved.
//

public protocol ErrorPresenter: Listener {
    func dismissError()
}

public final class ErrorPresenterImpl: BasePresenter<ErrorView>, ErrorPresenter {

    private let errorController: ErrorController
    private let errorHandlingPolicy: ErrorHandlingPolicy
    private let defaultErrorConvertor: DisplayableErrorConvertor

    public init(errorController: ErrorController, errorHandlingPolicy: ErrorHandlingPolicy, defaultErrorConvertor: DisplayableErrorConvertor) {
        self.errorController = errorController
        self.errorHandlingPolicy = errorHandlingPolicy
        self.defaultErrorConvertor = defaultErrorConvertor
        super.init()
        subscribeErrorController()
    }

    public func dismissError() {
        errorController.finishHandling()
    }

    private func subscribeErrorController() {
        errorController.subscribe(self, errorBlock: nil) { [weak self] _ in
            self?.handleUpdate()
        }
    }

    private func handleUpdate() {
        if let error = errorController.getError() {
            if errorHandlingPolicy.isHandlable(error: error) {
                handleError(error)
            } else {
                errorController.finishHandling()
            }
        }
    }

    private func handleError(_ error: Error) {
        let errorConvertor = errorController.getConvertor()
        guard let displayableError = errorConvertor?.convertError(error) ?? defaultErrorConvertor.convertError(error) else { return }

        if let view = self.view, !view.isErrorCurrentlyShown() {
            view.showError(displayableError, dismissTitle: localize("error_title_ok"))
        }
    }
}
