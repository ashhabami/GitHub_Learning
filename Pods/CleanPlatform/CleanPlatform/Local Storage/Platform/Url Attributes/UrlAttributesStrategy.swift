//
//  UrlAttributesStrategy.swift
//  CleanCore
//
//  Created by Jan Halousek on 11/02/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import Foundation

public protocol UrlAttributesStrategy {
    func addAttributes(to url: URL) throws
}
