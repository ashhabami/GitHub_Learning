//
//  UrlEncoder.swift
//  FMC
//
//  Created by Ondrej Fabian on 20/07/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public protocol UrlEncoder {
    func urlEncode(_ string: String) -> String
    func urlEncodeParameter(_ parameter: String) -> String
}
