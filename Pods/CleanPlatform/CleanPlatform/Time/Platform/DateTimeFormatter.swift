//
//  DateTimeFormatter.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 08/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import CleanCore
import Foundation

final class DateTimeFormatterImpl: DateTimeFormatter {
    private let dateFormatter = DateFormatter()

    func format(timestamp: Timestamp, format: DateTimeFormat) -> String {
        dateFormatter.dateFormat = format.format
        let date = Date(timeIntervalSince1970: timestamp)
        return dateFormatter.string(from: date)
    }
}
