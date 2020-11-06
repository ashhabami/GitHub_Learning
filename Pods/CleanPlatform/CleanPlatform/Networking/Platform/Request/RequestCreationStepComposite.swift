//
//  RequestCreationStepComposite.swift
//  CleanCore
//
//  Created by Ondrej Fabian on 01/11/2017.
//  Copyright © 2017 Cleverlance. All rights reserved.
//

import Foundation
import CleanCore

public final class RequestCreationStepComposite: RequestCreationStep {

    private let creationSteps: [RequestCreationStep]

    public init(creationSteps: [RequestCreationStep]) {
        self.creationSteps = creationSteps
    }

    public func createRequest(from request: HttpNetworkRequest) throws -> HttpNetworkRequest {
        var createdRequest = request
        for creationStep in creationSteps {
            createdRequest = try creationStep.createRequest(from: createdRequest)
        }
        return createdRequest
    }
}
