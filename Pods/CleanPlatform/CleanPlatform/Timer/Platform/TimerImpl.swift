//
//  TimerImpl.swift
//  FMC
//
//  Created by Libor Huspenina on 30/08/2016.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import Foundation
import CleanCore

public final class EventTimerImpl: EventTimer {
    private var closure: Block?
    private weak var timer: Timer?

    public init() { }

    public func start(_ frequency: Miliseconds, closure: @escaping Block) {
        setupTimer(miliseconds: frequency, closure: closure, selector: #selector(timerSelector), repeats: true)
    }

    public func stop() {
        self.closure = nil
        self.timer?.invalidate()
        self.timer = nil
    }

    public func fireOnce(_ after: Miliseconds, closure: @escaping Block) {
        setupTimer(miliseconds: after, closure: closure, selector: #selector(timerSelectorForSingleShot), repeats: false)
    }

    private func setupTimer(miliseconds: Miliseconds, closure: @escaping Block, selector: Selector, repeats: Bool) {
        stop()
        self.closure = closure
        let timeInterval: TimeInterval = Double(miliseconds) / 1000
        let timer = Timer(timeInterval: timeInterval, target: self, selector: selector, userInfo: nil, repeats: repeats)
        RunLoop.current.add(timer, forMode: .common)
        self.timer = timer
    }

    @objc private dynamic func timerSelectorForSingleShot() {
        let closure = self.closure
        self.stop()
        closure?()
    }

    @objc private dynamic func timerSelector() {
        self.closure?()
    }
}
