//
//  LoadingViewFactory.swift
//  CleanPlatform_iOS
//
//  Created by Ondrej Fabian on 15/06/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

import UIKit

public class LoadingViewFactory {
    public static var loadingView: (() -> LoadingView)?

    public func makeLoadingView() -> LoadingView {
        guard let loadingViewFactoryMethod = LoadingViewFactory.loadingView else {
            fatalError("LoadingViewFactory needs a loadingView factory method!")
        }
        return loadingViewFactoryMethod()
    }
}
