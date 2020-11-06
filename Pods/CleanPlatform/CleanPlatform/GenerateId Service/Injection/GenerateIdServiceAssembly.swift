//
//  GenerateIdServiceAssembly.swift
//  FMC
//
//  Created by Libor Huspenina on 08/02/2017.
//  Copyright (c) 2017 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

final class GenerateIdServiceAssembly: Assembly {

    func assemble(container: Container) {
        container.register(GenerateIdService.self) { _ in
            return GenerateIdServiceImpl()
        }
    }
}
