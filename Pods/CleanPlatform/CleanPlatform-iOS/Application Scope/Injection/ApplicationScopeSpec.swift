//
//  ApplicationScopeSpec.swift
//  CleanCore
//
//  Created by Ondrej Fabian on 08/11/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import Swinject

open class ApplicationScopeSpec: ApplicationCommonScopeSpec {

    override public init() {
        super.init()
    }

    open override func assemblies() -> [Assembly] {
        return super.assemblies() + [
            ClipboardAssembly(),
            ErrorAssembly(),
            NetworkDetectionAssembly(),
            PushNotificationsAssembly(),
            LoadingAssembly(),
        ]
    }
}
