//
//  Result.swift
//  Creditas
//
//  Created by Jakub Vaňo on 27/02/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public enum Result<Response> {
    case success(response: Response)
    case failure(error: Error)
}
