//
//  CredintalsKeychainService.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 04.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation

protocol CredentialsKeychainService {
    func storeCredentials(_ credintails: String) throws
    func loadCredentials() throws -> String
    func deleteCredentials() throws
}
