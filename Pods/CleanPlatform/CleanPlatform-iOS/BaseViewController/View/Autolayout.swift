//
//  Autolayout.swift
//  FMC
//
//  Created by Libor Huspenina on 28/07/2016.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import UIKit

public extension UIView {

    func setupConstraintsToFillSuperview() {
        self.setupConstraintsToFillSuperviewWithOffset(0)
    }

    func setupConstraintsToFillSuperviewWithOffset(_ offset: CGFloat) {
        setupConstraintsToFillSuperviewWithOffset(left: offset, top: offset, right: offset, bottom: offset)
    }

    func setupConstraintsToFillSuperviewWithOffset(left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let viewConstraints: [NSLayoutConstraint] = {
            let metrics = ["left": left, "top": top, "right": right, "bottom": bottom]
            let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(left)-[view]-(right)-|", options: [], metrics: metrics, views: ["view": self])
            let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(top)-[view]-(bottom)-|", options: [], metrics: metrics, views: ["view": self])
            return horizontalConstraints + verticalConstraints
        }()
        NSLayoutConstraint.activate(viewConstraints)
    }
}
