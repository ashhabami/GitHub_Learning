//
//  EventTimer.swift
//  FMC
//
//  Created by Libor Huspenina on 30/08/2016.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public typealias Miliseconds = Int

public protocol EventTimer {
    func start(_ frequency: Miliseconds, closure: @escaping Block)
    func fireOnce(_ after: Miliseconds, closure: @escaping Block)
    func stop()
}
