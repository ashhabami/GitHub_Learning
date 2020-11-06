//
//  LoadingView.swift
//  CleanCore
//
//  Created by Ondrej Fabian on 15/06/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

import UIKit

public protocol LoadingView {
    func show()
    func hide()
    func setup(font: UIFont, color: UIColor, background: UIColor)
    func getUIView() -> UIView
}
