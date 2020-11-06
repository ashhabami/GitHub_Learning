//
//  DefaultGenericConfiguration.swift
//  CleanPlatform
//
//  Created by Ondrej Fabian on 01/11/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import CleanCore

public class DefaultGenericConfiguration: GenericConfiguration {
    public func allowInvalidCertificates() -> Bool {
        return false
    }
    
    public func baseUrl() -> String {
        return "https://"
    }
    
    public func headers() -> [String : String] {
        return [:]
    }
}
