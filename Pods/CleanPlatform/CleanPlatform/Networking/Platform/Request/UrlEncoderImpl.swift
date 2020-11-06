//
//  UrlEncoderImpl.swift
//  FMC
//
//  Created by Ondrej Fabian on 20/07/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import Foundation
import CleanCore

public final class UrlEncoderImpl: UrlEncoder {

    public init() { }

    public func urlEncode(_ string: String) -> String {
        if let encodedString = string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            return encodedString
        }

        return string
    }

    public func urlEncodeParameter(_ parameter: String) -> String {
        let unreservedSet = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "-._~"))
        if let encodedString = parameter.addingPercentEncoding(withAllowedCharacters: unreservedSet) {
            return encodedString
        }

        return parameter
    }
}
