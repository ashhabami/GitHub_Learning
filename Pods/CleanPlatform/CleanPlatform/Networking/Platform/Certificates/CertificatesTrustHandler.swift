//
//  CertificatesTrustHandler.swift
//  CleanCore
//
//  Created by Jakub Mejtský on 21.02.18.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

import Foundation

public struct ProtectedSpace {
    public let host: String

    public init(host: String) {
        self.host = host
    }
}

public protocol CertificatesTrustHandler {
    func allowCertificates(_ certificates: [Data], for protectedSpace: ProtectedSpace) -> Bool
}
