//
//  GenerateIdServiceImpl.swift
//  FMC
//
//  Created by Libor Huspenina on 08/02/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import Foundation
import CleanCore

public final class GenerateIdServiceImpl: GenerateIdService {

    public init() { }

    public func generateId() -> Int {
        return Int(arc4random())
    }
}
