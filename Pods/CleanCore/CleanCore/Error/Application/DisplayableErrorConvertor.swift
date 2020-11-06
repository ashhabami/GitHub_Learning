//
//  DisplayableErrorConvertor.swift
//  FMC
//
//  Created by Ondrej Fabian on 26/07/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public protocol DisplayableErrorConvertor {
    func convertError(_ error: Error) -> DisplayableError?
}
