//
//  EventTimerConfiguration.swift
//  CleanCore
//
//  Created by Ondrej Fabian on 30/08/2018.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

public protocol EventTimerConfiguration {
    func getFrequency() -> Miliseconds
}

public class EventTimerConfigurationImpl: EventTimerConfiguration {

    public init() { }
    
    public func getFrequency() -> Miliseconds {
        return 1000
    }
}
