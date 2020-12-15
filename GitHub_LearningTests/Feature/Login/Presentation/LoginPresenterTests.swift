//
//  LoginPresenterTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 14.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import XCTest
import CleanCore
@testable import GitHub_Learning

class LoginPresenterTests: XCTestCase {
    private var sut: LoginPresenterImpl!
    
    private func setUpTests(
        loginBuilder: LoginBuilder = LoginBuilderDummy(isMandatoryDataFilled: false),
        alertProvider: AlertProviderController = AlertProviderControllerDummy(),
        loginController: LoginController = LoginControllerDummy(),
        loginView: LoginView = LoginViewDummy()
    ) {
        sut = LoginPresenterImpl(
            loginBuilder: loginBuilder,
            alertProvider: alertProvider,
            loginController: loginController
        )
        sut.view = loginView
    }
    
    func test_givenTestEmail_whenUpdateEmail_thenIsLoginEnabledIsCalled() {
        // Given
        let testEmail = "test@gmail.com"
        let view = LoginViewDummy()
        setUpTests(loginView: view)
        
        // When
        sut.updateEmail(testEmail)
        
        // Then
        XCTAssert(view.isLoginEnabledCalled == true)
    }
    
    func test_givenTestEmail_whenUpdateEmail_thenLoginBuildersEmailIsFilled() {
        // Given
        let testEmail = "test@gmail.com"
        let builder = LoginBuilderDummy(isMandatoryDataFilled: false)
        setUpTests(loginBuilder: builder)
        
        // When
        sut.updateEmail(testEmail)
        
        // then
        XCTAssert(builder.email == testEmail)
    }
    
    func test_givenTestPassword_whenUpdatePassword_thenIsLoginEnabledIsCalled() {
        // Given
        let testPassword = "Test123567"
        let view = LoginViewDummy()
        setUpTests(loginView: view)
        
        // When
        sut.updateEmail(testPassword)
        
        // Then
        XCTAssert(view.isLoginEnabledCalled == true)
    }
    
    func test_givenTestPassword_whenUpdatePassword_thenLoginBuildersPasswordIsFilled() {
        // Given
        let testPassword = "Test123567"
        let builder = LoginBuilderDummy(isMandatoryDataFilled: false)
        setUpTests(loginBuilder: builder)
        
        // When
        sut.updateEmail(testPassword)
        
        // Then
        XCTAssert(builder.email == testPassword)
    }
    
    func test_givenMandatoryDataFilled_whenUpdateCredentails_thenLoginIsEnabled() {
        // Given
        let testEmail = "test@gmail.com"
        let testPassword = "Test123567"
        let builder = LoginBuilderDummy(isMandatoryDataFilled: true)
        let view = LoginViewDummy()
        setUpTests(loginBuilder: builder, loginView: view)
        
        // When
        sut.updateEmail(testEmail)
        sut.updatePassword(testPassword)
        
        // Then
        XCTAssert(view.isLoginEnabled == true)
    }
    
    func test_givenMandatoryDataNotFilled_whenUpdateCredentails_thenLoginIsNotEnabled() {
        // Given
        let testEmail: String? = nil
        let testPassword = "Test123567"
        let view = LoginViewDummy()
        let builder = LoginBuilderDummy(isMandatoryDataFilled: false)
        setUpTests(loginBuilder: builder, loginView: view)
        
        // When
        sut.updateEmail(testEmail)
        sut.updatePassword(testPassword)
        
        // Then
        XCTAssert(view.isLoginEnabled == false)
    }
    
    func test_givenMandatoryDataFilled_whenLogIn_thenLogInWithIsCalled() {
        // Given
        let loginController = LoginControllerDummy()
        let builder = LoginBuilderDummy(isMandatoryDataFilled: true)
        setUpTests(loginBuilder: builder, loginController: loginController)
        
        // When
        sut.logIn()
        
        // Then
        XCTAssert(loginController.isLogedIn == true)
    }
    
    func test_givenMandatoryDataNotFilled_whenLogIn_thenLogInWithIsNotCalledAndErrorIsThrown() {
        // Given
        let loginController = LoginControllerDummy()
        let builder = LoginBuilderDummy(isMandatoryDataFilled: false) { throw LoginBuilderError.missingMandatoryData }
        setUpTests(loginBuilder: builder, loginController: loginController)
        
        // When
        sut.logIn()
        
        // Then
        XCTAssertNil(loginController.isLogedIn)
    }
    
    private class LoginBuilderDummy: LoginBuilder {
        var email: String?
        var password: String?
        var isMandatoryDataFilled: Bool { _isMandatoryDataFilled }
        
        private var _isMandatoryDataFilled: Bool
        private var _build: () throws -> LoginCredentials
        
        init(
            isMandatoryDataFilled: Bool,
            build: @escaping () throws -> LoginCredentials = { return LoginCredentials(email: "dummy", password: "dummy") }
        ) {
            _isMandatoryDataFilled = isMandatoryDataFilled
            _build = build
        }
        
        func build() throws -> LoginCredentials { try _build() }
    }
    
    private class LoginViewDummy: TestView, LoginView {
        var isLoginEnabledCalled: Bool?
        var isLoginEnabled: Bool?
        
        func isLoginEnabled(_ isEnabled: Bool) {
            isLoginEnabledCalled = true
            isLoginEnabled = isEnabled
        }
    }
    
    private class AlertProviderControllerDummy: TestController, AlertProviderController {
        var alert: Alert?
        
        func showAlertWith(_ title: String, message: String, actions: [AlertAction]?) {
            alert = Alert(
                title: title,
                message: message,
                actions: actions
            )
        }
        
        struct Alert {
            let title: String
            let message: String
            let actions: [AlertAction]?
        }
    }
    
    private class LoginControllerDummy: TestController, LoginController {
        var isLogedIn: Bool?
        var email: String?
        
        func logInWith(_ email: String) {
            isLogedIn = true
            self.email = email
        }
    }
}
