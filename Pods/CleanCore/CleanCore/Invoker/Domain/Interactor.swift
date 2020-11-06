//
//  Interactor.swift
//  FMC
//
//  Created by Ondrej Fabian on 13/05/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public protocol Interactor: Equatable {

    associatedtype Request
    associatedtype Response

    func execute(_ request: Request) throws -> Response
}
