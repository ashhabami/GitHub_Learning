//
//  BasePresenter.swift
//  FMC
//
//  Created by Ondrej Fabian on 30/06/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

open class BasePresenter<View> {
    private weak var internalView: AnyObject?

    public var view: View? {
        set {
            internalView = newValue as AnyObject
        }
        get {
            return internalView as? View
        }
    }

    public init() { }
}
