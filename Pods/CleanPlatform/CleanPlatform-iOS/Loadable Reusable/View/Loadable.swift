//
//  Loadable.swift
//  CleanPlatform_iOS
//
//  Created by Jan Halousek on 09/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import UIKit

public protocol Loadable { }

public extension Loadable where Self: AnyObject {
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }

    fileprivate static var nibName: String {
        return "\(Self.self)"
    }
}

public extension Loadable where Self: UIView {
    static func loadFromNib() -> Self {
        if let instance = nib.instantiate(withOwner: nil, options: nil).first as? Self {
            return instance
        } else {
            fatalError("Failed to instantiate view with Nib name: \(nibName)")
        }
    }

    static func create() -> Self {
        return loadFromNib()
    }

    static func make() -> Self {
        return loadFromNib()
    }
}
