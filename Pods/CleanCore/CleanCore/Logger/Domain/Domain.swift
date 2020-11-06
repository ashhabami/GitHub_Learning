//
//  Domain.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 28/06/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

public struct Domain: Hashable {
    public static let `default` = Domain(text: "default")
    public static let network = Domain(text: "network")
    public static let scope = Domain(text: "scope")
    public static let command = Domain(text: "command")
    public static let userInterface = Domain(text: "userInterface")
    public static let storage = Domain(text: "storage")

    public let text: String

    public init(text: String) {
        self.text = text
    }
}
