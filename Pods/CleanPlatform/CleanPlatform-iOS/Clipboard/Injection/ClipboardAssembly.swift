//
//  ClipboardAssembly.swift
//  FMC
//
//  Created by Ondrej Fabian on 22/02/2017.
//  Copyright (c) 2017 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

final class ClipboardAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ClipboardService.self) { _ in
            ClipboardServiceImpl()
        }
    }
}
