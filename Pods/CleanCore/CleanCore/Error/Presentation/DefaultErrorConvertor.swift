//
//  DefaultErrorConvertor.swift
//  CleanCore
//
//  Created by Libor Huspenina on 22/03/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

open class DefaultErrorConvertor: DisplayableErrorConvertor {

    public init() { }

    open func convertError(_ error: Error) -> DisplayableError? {
        var title = localize("error_title_unknown")
        var message = ""

        if let resourceError = error as? ResourceError {
            switch resourceError {
            case .requestCreation:
                title = localize("error_title_unknown")
            case .remoteResource:
                title = localize("error_title_network")
            case .server:
                title = localize("error_title_server")
            case .client:
                title = localize("error_title_unknown")
            case .incorrectResponse:
                title = localize("error_title_unknown")
            case .authentication:
                title = localize("error_title_unknown")
            case .business(let businessError):
                title = businessError.error
                message = businessError.description
            }
        }
        return DisplayableError(title: title, message: message)
    }
}
