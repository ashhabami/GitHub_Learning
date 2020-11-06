//
//  ClipboardServiceImpl.swift
//  FMC
//
//  Created by Libor Huspenina on 21/10/2016.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import UIKit
import CleanCore

public final class ClipboardServiceImpl: ClipboardService {

    public init() { }

    public func setText(_ text: String) {
        UIPasteboard.general.string = text
    }
}
