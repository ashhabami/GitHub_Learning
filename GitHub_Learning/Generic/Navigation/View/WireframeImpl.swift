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
    private let mainAppTabBar: MainAppTabBarController
    
    init(
        instanceProvider: InstanceProvider,
        window: UIWindow,
        mainAppTabBar: MainAppTabBarController
    ) {
        self.instanceProvider = instanceProvider
        self.window = window
        self.mainAppTabBar = mainAppTabBar
    }
    
    func launchLoginAfter(_ point: LoginLaunchPoint) {
        switch point {
        case .onboarding: presentViewControllerModally(LoginViewController.self, with: .fullScreen, animated: true)
        case .dashboard: setLoginAsRoot(animated: true)
        case .start: setLoginAsRoot(animated: false)
        }
    }
    
    func launchAlertWith(_ title: String, message: String, actions: [AlertAction]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach {
            let alertAction = UIAlertAction(action: $0)
            alert.addAction(alertAction)
        }
        window.topViewController?.present(alert, animated: true, completion: nil)
    }
    
    func launchDashboard(from point: DashboardLaunchPoint) {
        switch point {
        case .login:
            let tabbar = makeTabBarController()
            self.window.rootViewController = tabbar  
        case .startUp:
            let tabbar = makeTabBarController()
            self.window.rootViewController = tabbar
        }
    }
    
    func setOnboardingAsRoot() {
        setViewControllerAsRoot(OnboardingViewController.self)
    }
    
    private func setLoginAsRoot(animated: Bool) {
        if animated {
            UIView.transition(with: window, duration: 0.6, options: [.preferredFramesPerSecond60,.transitionCurlDown], animations: {
                self.setViewControllerAsRoot(LoginViewController.self)
            })
        } else {
            self.setViewControllerAsRoot(LoginViewController.self)
        }
    }
    
    private func setViewControllerAsRoot<T: UIViewController>(_ viewController: T.Type) {
        let vc = try! instanceProvider.getInstance(T.self)
        window.rootViewController = vc
    }
    
    private func presentViewControllerModally<T: UIViewController>(_ viewController: T.Type, with presentationStyle: UIModalPresentationStyle? = nil, animated: Bool, completion: (() -> Void)? = nil) {
        let vc = try! instanceProvider.getInstance(T.self)
        vc.modalPresentationStyle = presentationStyle ?? .automatic
        window.topViewController?.present(vc, animated: animated, completion: completion)
    }
    
    private func makeTabBarController() -> MainAppTabBarController {
        let dashboardVC = try! instanceProvider.getInstance(DashboardViewController.self)
        let dashboardNavController = try! instanceProvider.getInstance(MainAppNavigationController.self)
        dashboardNavController.setViewControllers([dashboardVC], animated: true)
        
        let favouritesVC = try! instanceProvider.getInstance(FavouritesViewController.self)
        let favouritesNavController = try! instanceProvider.getInstance(MainAppNavigationController.self)
        favouritesNavController.setViewControllers([favouritesVC], animated: true)
        
        let newsVC = try! instanceProvider.getInstance(NewsViewController.self)
        let newsStubNavController = try! instanceProvider.getInstance(MainAppNavigationController.self)
        newsStubNavController.setViewControllers([newsVC], animated: true)
        
        let portfolioVC = try! instanceProvider.getInstance(PortfolioViewController.self)
        let portfolioFakeNavController = try! instanceProvider.getInstance(MainAppNavigationController.self)
        portfolioFakeNavController.setViewControllers([portfolioVC], animated: true)
        
        mainAppTabBar.setViewControllers([dashboardNavController, favouritesNavController, newsStubNavController, portfolioFakeNavController], animated: false)
        return mainAppTabBar
    }
}
