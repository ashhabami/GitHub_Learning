//
//  DateTimeAssembly.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 08/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import Swinject
import CleanCore

final class DateTimeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(DateTimeFormatter.self) { _ in
            DateTimeFormatterImpl()
        }
    }
}

