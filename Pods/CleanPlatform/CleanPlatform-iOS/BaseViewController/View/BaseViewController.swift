//
//  BaseViewController.swift
//  FMC
//
//  Created by Ondrej Fabian on 13/07/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import UIKit
import CleanCore

open class BaseViewController: UIViewController, View, LoadingOverlay, UIGestureRecognizerDelegate {

    open override func viewDidLoad() {
        super.viewDidLoad()
        addReleaseKeyboardGestureRecognizer()
    }

    open func startLoading() {
        startOverlayLoading()
    }

    open func stopLoading() {
        stopOverlayLoading()
    }

    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let isUIControl = touch.view is UIControl
        return !isUIControl
    }

    private func addReleaseKeyboardGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.delegate = self
        tap.delaysTouchesBegan = false
        tap.delaysTouchesEnded = false
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc public func hideKeyboard(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    func getKeyboardHeight(_ notification: Notification) -> CGFloat? {
        guard let userInfo = notification.userInfo, let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return nil
        }
        return frame.cgRectValue.height
    }

    func insertViewController(_ childController: UIViewController) {
        childController.willMove(toParent: self)
        addChild(childController)
        view.addSubview(childController.view)
        childController.view.setupConstraintsToFillSuperview()
        childController.didMove(toParent: self)
    }
}
