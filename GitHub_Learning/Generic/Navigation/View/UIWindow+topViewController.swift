//
//  UIWindow + topViewController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 16/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import UIKit

extension UIWindow {
    public var topViewController: UIViewController? {
        return topViewControllerFrom(base: rootViewController)
    }
    
    private func topViewControllerFrom(base: UIViewController?) -> UIViewController? {
        guard let presented = base?.presentedViewController else { return base }
        return topViewControllerFrom(base: presented)
    }
}

