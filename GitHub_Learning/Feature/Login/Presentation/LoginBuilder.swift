//
//  LoginBuilder.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 19/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation

enum LoginBuilderError: Error {
    case missingMandatoryData
    case invalidEmail
    case invalidPassword
}

protocol LoginBuilder: AnyObject {
    var email: String? { get set }
    var password: String? { get set }
    var isMandatoryDataFilled: Bool { get }
    func build() throws -> LoginCredentials
}

class LoginBuilderImpl {
    var email: String?
    var password: String?
    var isMandatoryDataFilled: Bool {
        guard let email = email, let password = password else { return false }
        return !email.isEmpty && !password.isEmpty
    }
    private var isEmailValid: Bool {
        guard let email = email else { return false }
        return email.isEmail
    }
    private var isPasswordValid: Bool {
        guard let password = password else { return false }
        return password.containsNumber && password.containsCapital && password.count > 7
    }
}

extension LoginBuilderImpl: LoginBuilder {
    func build() throws -> LoginCredentials {
        guard let email = email, let password = password else {
            throw LoginBuilderError.missingMandatoryData
        }
        guard isEmailValid else {
            throw LoginBuilderError.invalidEmail
        }
        guard isPasswordValid else {
            throw LoginBuilderError.invalidPassword
        }
        return LoginCredentials(email: email, password: password)
    }
}
