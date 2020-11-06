//
//  NetworkClientConfig.swift
//  FMC
//
//  Created by Ondrej Fabian on 25/05/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public protocol NetworkClientConfig {
    func allowInvalidCertificates() -> Bool
}
