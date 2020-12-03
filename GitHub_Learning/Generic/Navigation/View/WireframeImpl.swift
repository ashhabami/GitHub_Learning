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
    let instanceProvider: InstanceProvider
    let window: UIWindow
    
    init(
        instanceProvider: InstanceProvider,
        window: UIWindow
    ) {
        self.instanceProvider = instanceProvider
        self.window = window
    }
    
    func launchLogin() {
        let vc = try! instanceProvider.getInstance(LoginViewController.self)
        vc.modalPresentationStyle = .fullScreen
        window.topViewController?.present(vc, animated: true, completion: nil)
    }
    
    func launchAlertWith(_ title: String, message: String, actions: [AlertAction]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach {
            let alertAction = UIAlertAction(action: $0)
            alert.addAction(alertAction)
        }
        window.topViewController?.present(alert, animated: true, completion: nil)
    }
    
    func setOnboardingAsRoot() {
        let vc = try! instanceProvider.getInstance(OnboardingViewController.self)
        window.rootViewController = vc
    }
    
    func setLoginAsRoot() {
        let vc = try! instanceProvider.getInstance(LoginViewController.self)
        window.rootViewController = vc
    }
}
