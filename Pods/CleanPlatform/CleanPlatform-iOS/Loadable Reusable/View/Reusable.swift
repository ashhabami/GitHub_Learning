//
//  Reusable.swift
//  CleanPlatform_iOS
//
//  Created by Jan Halousek on 09/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import UIKit

public protocol Reusable {
    static var reusableIdentifier: String { get }
}

public extension Reusable {
    static var reusableIdentifier: String {
        return "\(Self.self)"
    }
}
