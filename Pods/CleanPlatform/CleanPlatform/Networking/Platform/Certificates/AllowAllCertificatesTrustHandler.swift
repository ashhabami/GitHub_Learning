//
//  AllowAllCertificatesTrustHandler.swift
//  CleanCore
//
//  Created by Jakub Mejtský on 21.02.18.
//  Copyright © 2018 Cleverlance. All rights reserved.
//

import Foundation

public class AllowAllCertificatesTrustHandler: CertificatesTrustHandler {

    public init() { }

    public func allowCertificates(_ certificates: [Data], for protectedSpace: ProtectedSpace) -> Bool {
        return true
    }
}
