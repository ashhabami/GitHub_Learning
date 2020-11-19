//
//  LoginBuilder.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 19/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation

enum LoginBuilderError: Error {
    case unfilledEmail
    case unfilledPassword
    case invalidEmail
    case invalidPassword
}

protocol LoginBuilder {
    var email: String? {get set}
    var password: String? {get set}
    func build() throws -> LoginCredentials
}

class LoginBuilderImpl {
    var email: String? {
        didSet {
            _isEmailValid = isEmailValid()
        }
    }
    var password: String? {
        didSet {
            _isPasswordValid = isPasswordValid()
        }
    }
    var _isEmailValid: Bool = false
    var _isPasswordValid: Bool = false
    
    private func isEmailValid() -> Bool {
        if email!.contains("@") && email!.contains(".") {
            return true
        }
        return false
    }
    
    private func isPasswordValid() -> Bool {
        if password!.containsNumber && password!.containsCapital {
            return true
        }
        return false
    }
}

extension LoginBuilderImpl: LoginBuilder {
    func build() throws -> LoginCredentials {
        guard let email = email, email != "" else {
            throw LoginBuilderError.unfilledEmail
        }
        guard let password = password, password != "" else {
            throw LoginBuilderError.unfilledPassword
        }
        guard _isEmailValid == true else {
            throw LoginBuilderError.invalidEmail
        }
        guard _isPasswordValid == true else {
            throw LoginBuilderError.invalidPassword
        }
        
        return LoginCredentials(email: email,password: password)
    }
}
