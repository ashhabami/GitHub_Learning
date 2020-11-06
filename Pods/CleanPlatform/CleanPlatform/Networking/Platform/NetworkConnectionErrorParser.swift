//
//  NetworkConnectionErrorParser.swift
//  CleanCore
//
//  Created by Jakub Mejtský on 27.02.18.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

import Foundation
import CleanCore

public protocol NetworkConnectionErrorParser {
    func parse(error: NSError) -> NetworkConnectionError
}

public class NetworkConnectionErrorParserImpl: NetworkConnectionErrorParser {

    public init() { }

    public func parse(error: NSError) -> NetworkConnectionError {
        switch (error.domain, error.code) {
        case (NSURLErrorDomain, NSURLErrorNotConnectedToInternet):
            return .networkUnavailable
        case (NSURLErrorDomain, NSURLErrorTimedOut):
            return .timeout
        default:
            return .other
        }
    }
}
