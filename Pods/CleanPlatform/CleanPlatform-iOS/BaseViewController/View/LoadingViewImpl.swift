//
//  LoadingViewImpl.swift
//  FMC
//
//  Created by Tomas Sliz on 29/07/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import CleanCore
import UIKit

open class LoadingViewImpl: UIView, LoadingView {

    public var loadingLabel: UILabel!
    public var activityIndicatorView: UIActivityIndicatorView!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        addLoadingLabel()
        addActivityIndicatorView()
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func show() {
        isHidden = false
    }

    public func hide() {
        isHidden = true
    }

    public func getUIView() -> UIView {
        return self
    }

    open func setup(font: UIFont = UIFont.systemFont(ofSize: 20.0), color: UIColor = UIColor.darkText, background: UIColor = .white) {
        loadingLabel.font = font
        loadingLabel.textColor = color
        activityIndicatorView.color = color
        backgroundColor = background
    }

    private func addLoadingLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = localize("loading_loading")
        addSubview(label)

        centerXAnchor.constraint(equalTo: label.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true

        loadingLabel = label
    }

    private func addActivityIndicatorView() {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true


        addSubview(indicator)

        centerXAnchor.constraint(equalTo: indicator.centerXAnchor).isActive = true
        indicator.topAnchor.constraint(equalTo: loadingLabel.bottomAnchor, constant: 30).isActive = true

        activityIndicatorView = indicator
        activityIndicatorView.startAnimating()
    }

}
