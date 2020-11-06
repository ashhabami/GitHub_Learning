//
//  LoadableViewController.swift
//  CleanPlatform_iOS
//
//  Created by Jan Halousek on 10/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import UIKit

public protocol LoadableViewController { }

public extension LoadableViewController where Self: AnyObject {
    static var storyboard: UIStoryboard {
        let bundle = Bundle(for: Self.self)
        return UIStoryboard(name: storyboardIdentifier, bundle: bundle)
    }

    fileprivate static var storyboardIdentifier: String {
        return "\(Self.self)"
    }
}

public extension LoadableViewController where Self: UIViewController {
    static func loadFromStoryboard() -> Self {
        if let instance = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self {
            return instance
        } else {
            fatalError("Failed to instantiate UIViewController with storyboard identifier: \(storyboardIdentifier)")
        }
    }

    static func create() -> Self {
        return loadFromStoryboard()
    }

    static func make() -> Self {
        return loadFromStoryboard()
    }
}
