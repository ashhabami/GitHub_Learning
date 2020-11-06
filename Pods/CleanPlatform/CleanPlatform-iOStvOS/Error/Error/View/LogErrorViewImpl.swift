//
//  LogErrorViewImpl.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 26/03/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

import UIKit
import CleanCore

public final class LogErrorViewImpl: ErrorView {

    private let presenter: ErrorPresenter

    public init(presenter: ErrorPresenter) {
        self.presenter = presenter
        logWarning("Register UIWindow to present error at UI. Alternatively override ErrorView registration.")
    }

    public func showError(_ error: DisplayableError, dismissTitle: String) {
        let errorMessage = "Error:\ntitle: \(error.title)\nmessage: \(error.message)"
        logWarning(errorMessage)
    }

    public func isErrorCurrentlyShown() -> Bool {
        return false
    }
}
