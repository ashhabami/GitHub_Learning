//
//  Data+Extensions.swift
//  FMC
//
//  Created by Libor Huspenina on 15/06/2016.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import CleanCore
import Foundation

public extension Data {

    func toArrayOfInts() -> Bytes {
        return Array(self)
    }

    init(data: Bytes) {
        self.init(data)
    }
}
