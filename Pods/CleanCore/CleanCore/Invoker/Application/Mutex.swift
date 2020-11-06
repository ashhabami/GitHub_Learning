//
//  Mutex.swift
//  CleanCore
//
//  Created by Libor Huspenina on 12/02/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

public typealias Mutex = String

public protocol Mutexable {
    var mutex: Mutex? { get }
}
