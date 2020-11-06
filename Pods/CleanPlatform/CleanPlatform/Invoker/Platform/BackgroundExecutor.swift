//
//  BackgroundExecutor.swift
//  Babylon
//
//  Created by Ondrej Fabian on 22/11/2015.
//  Copyright © 2015 Cleverlance. All rights reserved.
//

import Foundation
import CleanCore

public final class BackgroundExecutor: Executor {

    public init() { }

    public func executeCommand<CommandType: Command>(_ command: CommandType, completion: @escaping ValueBlock<Result<CommandType.Response>>) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {

            let result: Result<CommandType.Response>
            do {
                let response = try command.execute()
                result = Result.success(response: response)
            } catch {
                result = Result.failure(error: error)
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
