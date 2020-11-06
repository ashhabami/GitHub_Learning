//
//  LoadingAssembly.swift
//  CleanPlatform_iOS
//
//  Created by Ondrej Fabian on 15/06/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

import Swinject

final class LoadingAssembly: Assembly {

    func assemble(container: Container) {

        container.register(LoadingView.self) { r in
            return LoadingViewImpl()
        }
    }

    func loaded(resolver: Resolver) {
        LoadingViewFactory.loadingView = { resolver.resolve(LoadingView.self)! }
    }
}
