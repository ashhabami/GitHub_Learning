//
//  FileStoragePathResolver.swift
//  CleanCore
//
//  Created by Jan Halousek on 24/01/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

public protocol FileStoragePathResolver {
    func getBasePath() -> String?
}
