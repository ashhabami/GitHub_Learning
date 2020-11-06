//
//  CommandQueue.swift
//  FMC
//
//  Created by Ondrej Fabian on 15/08/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//
// swiftlint:disable force_cast

public final class CommandQueue {

    fileprivate var commandQueue = [AnyObject]()

    func isEmpty() -> Bool {
        return commandQueue.isEmpty
    }

    func enqueueCommand<CommandType: Command>(_ command: CommandType) {
        synchronize { [weak self] in
            self?.commandQueue.append(command as AnyObject)
        }
    }

    func isCommandAlreadyInQueue<CommandType: Command>(_ command: CommandType) -> Bool {
        return !getCommmandEqualTo(command).isEmpty
    }

    func countOfCommands(with mutex: Mutexable) -> Int {
        guard let commandMutex = mutex.mutex else { return 0 }
        let commands = commandQueue.compactMap { $0 as? Mutexable }
        return commands.filter({ commandMutex == $0.mutex }).count
    }

    func getCommmandEqualTo<CommandType: Command>(_ command: CommandType) -> [CommandType] {
        return synchronize {
            return self.commandQueue.filter { self.commandsEqual($0, command: command) }.map { $0 as! CommandType }
        }
    }

    func removeCommand<CommandType: Command>(_ command: CommandType) {
        synchronize {
            self.commandQueue = self.commandQueue.filter { $0 !== command as AnyObject}
        }
    }

    func removeAllCommandsEqualTo<CommandType: Command>(_ command: CommandType) {
        synchronize {
            self.commandQueue = self.commandQueue.filter { !self.commandsEqual($0, command: command) }
        }
    }

    private func commandsEqual<CommandType: Command>(_ enqueuedUntypedCommand: AnyObject, command: CommandType) -> Bool {
        if let enqueuedCommand = enqueuedUntypedCommand as? CommandType {
            return enqueuedCommand == command
        } else {
            return false
        }
    }
}

extension CommandQueue: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "CommandQueue: \(commandQueue)"
    }
}
