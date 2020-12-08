//
//  WireframeImpl.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 15/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore
import CleanPlatform

class WireframeImpl: Wireframe {
    private let instanceProvider: InstanceProvider
    private let window: UIWindow
    
    init(
        instanceProvider: InstanceProvider,
        window: UIWindow
    ) {
        self.instanceProvider = instanceProvider
        self.window = window
    }
    
    func launchLogin() {
        presentViewControllerModally(LoginViewController.self, with: .fullScreen)
    }
    
    func launchAlertWith(_ title: String, message: String, actions: [AlertAction]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach {
            let alertAction = UIAlertAction(action: $0)
            alert.addAction(alertAction)
        }
        window.topViewController?.present(alert, animated: true, completion: nil)
    }
    
    func launchDashboard(from point: LaunchPoint) {
        switch point {
        case .login:
            presentViewControllerModally(DashboardViewController.self, with: .fullScreen) {
                self.setViewControllerAsRoot(DashboardViewController.self)
            }
        case .startUp: setViewControllerAsRoot(DashboardViewController.self)
        }
    }
    
    func setOnboardingAsRoot() {
        setViewControllerAsRoot(OnboardingViewController.self)
    }
    
    func setLoginAsRoot() {
        setViewControllerAsRoot(LoginViewController.self)
    }
    
    private func setViewControllerAsRoot<T:UIViewController>(_ viewController: T.Type) {
        let vc = try! instanceProvider.getInstance(T.self)
        window.rootViewController = vc
    }
    
    private func presentViewControllerModally<T:UIViewController>(_ viewController: T.Type, with presentationStyle: UIModalPresentationStyle? = nil, completion: (() -> Void)? = nil) {
        let vc = try! instanceProvider.getInstance(T.self)
        vc.modalPresentationStyle = presentationStyle ?? .automatic
        window.topViewController?.present(vc, animated: true, completion: completion)
    }
}
