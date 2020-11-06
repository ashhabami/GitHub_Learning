//
//  FoundationLocalizer.swift
//  FMC
//
//  Created by Ondrej Fabian on 16/06/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import CleanCore
import Foundation

public final class FoundationLocalizer: Localizer {

    public init() { }

    public func localize(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
