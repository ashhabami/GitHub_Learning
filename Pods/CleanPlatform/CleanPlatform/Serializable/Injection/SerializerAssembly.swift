//
//  SerializerAssembly.swift
//  FMC
//
//  Created by Ondrej Fabian on 21/02/2017.
//  Copyright (c) 2017 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

final class SerializerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(Serializer.self) { r in
            return CodingSerializer()
        }
    }
}
