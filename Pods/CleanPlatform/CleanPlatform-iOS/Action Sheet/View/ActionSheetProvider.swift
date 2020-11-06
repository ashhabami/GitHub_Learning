//
//  ActionSheetProvider.swift
//  FMC
//
//  Created by Tomas Sliz on 09/08/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import UIKit

public protocol ActionSheetProvider {
    var window: UIWindow { get }
    var sourceView: UIView? { get set }
    var sourceRect: CGRect? { get set }
}

public final class ActionSheetProviderImpl: ActionSheetProvider {

    public let window: UIWindow
    public weak var sourceView: UIView? = nil
    public var sourceRect: CGRect? = nil

    public init(window: UIWindow) {
        self.window = window
    }

}
