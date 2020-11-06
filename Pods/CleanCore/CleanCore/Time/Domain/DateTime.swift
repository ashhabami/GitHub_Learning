//
//  DateTime.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 08/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

public struct DateTimeFormat: Hashable {
    /// format: yyyy-MM-dd
    public static let iso8601Date = DateTimeFormat(format: "yyyy-MM-dd")
    /// format: yyyy-MM-dd'T'HH:mm:ss.SSS'Z'
    public static let iso8601 = DateTimeFormat(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")

    public let format: String

    public init(format: String) {
        self.format = format
    }
}
