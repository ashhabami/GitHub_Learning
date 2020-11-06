//
//  DisplayableError.swift
//  FMC
//
//  Created by Ondrej Fabian on 26/07/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

open class DisplayableError {
    public let title: String
    public let message: String

    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}
