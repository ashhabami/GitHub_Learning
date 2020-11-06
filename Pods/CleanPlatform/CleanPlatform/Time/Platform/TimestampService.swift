//
//  TimestampService.swift
//  CleanCore
//
//  Created by Kryštof Matěj on 08/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import CleanCore
import Foundation

final class TimestampServiceImpl: TimestampService {
    func getTimestamp() -> Timestamp {
        return Date().timeIntervalSince1970
    }
}
