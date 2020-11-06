//
//  ErrorViewImpl.swift
//  FMC
//
//  Created by Ondrej Fabian on 25/07/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import UIKit
import CleanCore

public final class ErrorViewImpl: ErrorView {

    private let window: UIWindow
    private let presenter: ErrorPresenter
    private weak var currentlyDisplayedAlert: UIAlertController? = nil

    public init(presenter: ErrorPresenter, window: UIWindow) {
        self.presenter = presenter
        self.window = window
    }

    public func showError(_ error: DisplayableError, dismissTitle: String) {
        let alert = alertWithTitle(error.title, message: error.message, dismissTitle: dismissTitle)
        presentAlert(alert)
    }

    public func isErrorCurrentlyShown() -> Bool {
        return currentlyDisplayedAlert != nil
    }

    private func alertWithTitle(_ title: String, message: String, dismissTitle: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: dismissTitle, style: .default) { [weak self] _ in
            alert.dismiss(animated: true, completion: nil)
            self?.currentlyDisplayedAlert = nil
            self?.presenter.dismissError()
        }
        alert.addAction(action)
        return alert
    }

    private func presentAlert(_ alert: UIAlertController) {
        currentlyDisplayedAlert = alert
        if let presentedViewController = window.rootViewController?.presentedViewController {
            presentedViewController.present(alert, animated: true, completion: nil)
        } else {
            window.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
