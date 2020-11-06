//
//  LoadingOverlay.swift
//  FMC
//
//  Created by Ondrej Fabian on 05/10/2016.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import CleanCore
import UIKit

public protocol LoadingOverlay {
    var view: UIView! { get }
}

extension LoadingOverlay {

    private var loadingView: LoadingView {

        if let existingLoadingView = getExistingLoadingView() {
            return existingLoadingView
        } else {
            return setupNewLoadingView()
        }
    }

    public func startOverlayLoading() {
        if let tableView = view as? UITableView {
            if let loadingBackgroundView = tableView.backgroundView as? View {
                loadingBackgroundView.startLoading()
            }
        } else {
            loadingView.show()
            view.bringSubviewToFront(loadingView.getUIView())
        }
    }

    public func stopOverlayLoading() {
        if let tableView = view as? UITableView {
            if let loadingBackgroundView = tableView.backgroundView as? View {
                loadingBackgroundView.stopLoading()
            }
        } else {
            loadingView.hide()
        }
    }

    private func getExistingLoadingView() -> LoadingView? {
        return view.subviews.filter { subview in
            return subview is LoadingView
        }.first as? LoadingView
    }

    private func setupNewLoadingView() -> LoadingView {

        let loadingView = LoadingViewFactory().makeLoadingView()
        let view = loadingView.getUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true

        self.view.addSubview(view)

        self.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        return loadingView
    }
}
