//
//  Invoker.swift
//  Babylon
//
//  Created by Ondrej Fabian on 22/11/2015.
//  Copyright © 2015 Cleverlance. All rights reserved.
//

public protocol Invoker {
    func enqueueCommand<CommandType: Command>(_ command: CommandType)
}

public final class InvokerImpl: Invoker {

    private let executor: Executor
    private let activityController: ActivityController
    private let configuration: InvokerConfiguration
    public var errorHandler: ErrorHandler!

    let commandQueue: CommandQueue
    var waitingCommands: [Block] = []

    public init(executor: Executor, activityController: ActivityController, configuration: InvokerConfiguration) {
        self.executor = executor
        self.activityController = activityController
        self.configuration = configuration
        self.commandQueue = CommandQueue()
    }

    public func enqueueCommand<CommandType: Command>(_ command: CommandType) {
        let isSpaceForCommandInQueue = self.isSpaceForCommandInQueue(command)

        if isSpaceForCommandInQueue {
            let shouldExecute = !commandQueue.isCommandAlreadyInQueue(command)
            commandQueue.enqueueCommand(command)

            if shouldExecute {
                executeCommand(command)
            }
        } else {
            waitingCommands.append {
                self.enqueueCommand(command)
            }
        }
    }

    private func isSpaceForCommandInQueue<CommandType: Command>(_ command: CommandType) -> Bool {
        guard let mutex = command.mutex else {
             return true
        }

        return configuration.maximumCommands(for: mutex) > commandQueue.countOfCommands(with: command)
    }

    private func executeWaitingCommands() {
        let commandsToRetry = waitingCommands
        waitingCommands = []
        commandsToRetry.forEach { $0() }
    }

    private func executeCommand<CommandType: Command>(_ command: CommandType) {
        let id = logIntervalStart(String(describing: command), domain: .command)
        activityController.activityStarted(with: ObjectIdentifier(self).hashValue)
        executor.executeCommand(command) { result in
            switch result {
            case .success(let response):
                logIntervalEnd("\(command) response: \(response)", id: id)
                self.completeCommand(command, result: result)

            case .failure(let error):
                logIntervalEnd("\(command) error: \(error)", id: id)
                self.errorHandler.handleError(error) { errorHandled in
                    if errorHandled {
                        self.executeCommand(command)
                    } else {
                        self.completeCommand(command, result: result)
                    }
                }
            }
        }
    }

    private func completeCommand<CommandType: Command>(_ command: CommandType, result: Result<CommandType.Response>) {
        let sameCommandsToComplete = commandQueue.getCommmandEqualTo(command)
        if sameCommandsToComplete.isEmpty {
            command.complete(result)
            commandQueue.removeCommand(command)
        } else {
            sameCommandsToComplete.forEach { $0.complete(result) }
            commandQueue.removeAllCommandsEqualTo(command)
        }
        executeWaitingCommands()
        if commandQueue.isEmpty() {
            activityController.activityStopped(with: ObjectIdentifier(self).hashValue)
        }
    }

    deinit {
        activityController.activityStopped(with: ObjectIdentifier(self).hashValue)
    }
}
