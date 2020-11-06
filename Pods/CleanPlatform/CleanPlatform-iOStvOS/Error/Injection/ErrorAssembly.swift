//
//  ErrorAssembly.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 26/03/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore
import UIKit

final class ErrorAssembly: Assembly {

    func assemble(container: Container) {

        container.register(ErrorView.self) { r in
            let presenter = r.resolve(ErrorPresenter.self)!
            if let window = r.resolve(UIWindow.self) {
                return ErrorViewImpl(presenter: presenter, window: window)
            } else {
                return LogErrorViewImpl(presenter: presenter)
            }
        }.inObjectScope(.container)

        container.register(ErrorPresenter.self) { r in
            let errorController = r.resolve(ErrorController.self)!
            let errorHandlingPolicy = r.resolve(ErrorHandlingPolicy.self)!
            let defaultErrorConvertor = r.resolve(DisplayableErrorConvertor.self, name: ErrorCommonAssembly.defaultErrorConverterResolverName)!
            return ErrorPresenterImpl(errorController: errorController, errorHandlingPolicy: errorHandlingPolicy, defaultErrorConvertor: defaultErrorConvertor)
        }.initCompleted { r, presenter in
            if let presenter = presenter as? ErrorPresenterImpl {
                presenter.view = r.resolve(ErrorView.self)!
            }
        }
    }

    func loaded(resolver: Resolver) {
        _ = resolver.resolve(ErrorView.self)
    }
}
