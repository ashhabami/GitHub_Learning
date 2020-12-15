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
        loginBuilder: LoginBuilder = LoginBuilderDummy(),
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
        // given
        let testEmail = "test@gmail.com"
        let view = LoginViewDummy()
        setUpTests(loginView: view)
        
        // when
        sut.updateEmail(testEmail)
        
        // then
        XCTAssert(view.isLoginEnbaledCalled == true)
    }
    
    func test_givenTestEmail_whenUpdateEmail_thenLoginBuildersEmailIsFilled() {
        // given
        let testEmail = "test@gmail.com"
        let builder = LoginBuilderDummy()
        setUpTests(loginBuilder: builder)
        
        // when
        sut.updateEmail(testEmail)
        
        // then
        XCTAssert(builder.email == testEmail)
    }
    
    func test_givenTestPassword_whenUpdatePassword_thenIsLoginEnabledIsCalled() {
        // given
        let testPassword = "Test123567"
        let view = LoginViewDummy()
        setUpTests(loginView: view)
        
        // when
        sut.updateEmail(testPassword)
        
        // then
        XCTAssert(view.isLoginEnbaledCalled == true)
    }
    
    func test_givenTestPassword_whenUpdatePassword_thenLoginBuildersPasswordIsFilled() {
        // given
        let testPassword = "Test123567"
        let builder = LoginBuilderDummy()
        setUpTests(loginBuilder: builder)
        
        // when
        sut.updateEmail(testPassword)
        
        // then
        XCTAssert(builder.email == testPassword)
    }
    
    
    func test_givenMandatoryDataFilled_whenUpdateCredentails_thenLoginIsEnabled() {
        // given
        let testEmail = "test@gmail.com"
        let testPassword = "Test123567"
        let view = LoginViewDummy()
        setUpTests(loginView: view)
        
        // when
        sut.updateEmail(testEmail)
        sut.updatePassword(testPassword)
        
        // then
        XCTAssert(view.isLoginEnabled == true)
    }
    
    func test_givenEmailNotFilled_whenUpdateCredentails_thenLoginIsNotEnabled() {
        // given
        let testEmail: String? = nil
        let testPassword = "Test123567"
        let view = LoginViewDummy()
        setUpTests(loginView: view)
        
        // when
        sut.updateEmail(testEmail)
        sut.updatePassword(testPassword)
        
        // then
        XCTAssert(view.isLoginEnabled == false)
    }
    
    func test_givenPasswordNotFilled_whenUpdateCredentails_thenLoginIsNotEnabled() {
        // given
        let testEmail = "test@gmail.com"
        let testPassword: String? = nil
        let view = LoginViewDummy()
        setUpTests(loginView: view)
        
        // when
        sut.updateEmail(testEmail)
        sut.updatePassword(testPassword)
        
        // then
        XCTAssert(view.isLoginEnabled == false)
    }
    
    func test_givenEmailIsEmpty_whenUpdateCredentails_thenLoginIsNotEnabled() {
        // given
        let testEmail = ""
        let testPassword = "Test123567"
        let view = LoginViewDummy()
        setUpTests(loginView: view)
        
        // when
        sut.updateEmail(testEmail)
        sut.updatePassword(testPassword)
        
        // then
        XCTAssert(view.isLoginEnabled == false)
    }
    
    func test_givenPasswordIsEmpty_whenUpdateCredentails_thenLoginIsNotEnabled() {
        // given
        let testEmail = "test@gmail.com"
        let testPassword = ""
        let view = LoginViewDummy()
        setUpTests(loginView: view)
        
        // when
        sut.updateEmail(testEmail)
        sut.updatePassword(testPassword)
        
        // then
        XCTAssert(view.isLoginEnabled == false)
    }
    
    func test_givenValidCredentails_whenLogIn_thenLogInWithIsCalled() {
        // given
        let testEmail = "test@gmail.com"
        let testPassword = "Test123567"
        let loginController = LoginControllerDummy()
        let builder = LoginBuilderDummy()
        setUpTests(loginBuilder: builder, loginController: loginController)
        
        // when
        builder.email = testEmail
        builder.password = testPassword
        sut.logIn()
        
        // then
        XCTAssert(loginController.isLogedIn == true)
    }
    
    func test_givenValidCredentails_whenLogIn_thenNoAlertIsThrown() {
        // given
        let testEmail = "test@gmail.com"
        let testPassword = "Test123567"
        let builder = LoginBuilderDummy()
        let provider = AlertProviderControllerDummy()
        setUpTests(loginBuilder: builder, alertProvider: provider)
        
        // when
        builder.email = testEmail
        builder.password = testPassword
        sut.logIn()
        
        // then
        XCTAssertNil(provider.alert)
    }
    
    func test_givenUnvalidEmail_whenLogIn_thenLogInWithIsNotCalled() {
        // given
        let testEmail = "test@gmail.c"
        let testPassword = "Test123567"
        let loginController = LoginControllerDummy()
        let builder = LoginBuilderDummy()
        setUpTests(loginBuilder: builder, loginController: loginController)
        
        // when
        builder.email = testEmail
        builder.password = testPassword
        sut.logIn()
        
        // then
        XCTAssertNil(loginController.isLogedIn)
    }
    
    func test_givenUnvalidEmail_whenLogIn_thenInvalidEmailAlertIsThrown() {
        // given
        let testEmail = "test@gmail.c"
        let testPassword = "Test123567"
        let alertTitle = "Invalid Email"
        let builder = LoginBuilderDummy()
        let provider = AlertProviderControllerDummy()
        setUpTests(loginBuilder: builder, alertProvider: provider)
        
        // when
        builder.email = testEmail
        builder.password = testPassword
        sut.logIn()
        
        // then
        XCTAssertNotNil(provider.alert)
        XCTAssert(alertTitle == provider.alert?.title)
    }
    
    func test_givenUnvalidPassword_whenLogIn_thenInvalidPasswordAlertIsThrown() {
        // given
        let testEmail = "test@gmail.com"
        let testPassword = "Test"
        let alertTitle = "Invalid Password"
        let builder = LoginBuilderDummy()
        let provider = AlertProviderControllerDummy()
        setUpTests(loginBuilder: builder, alertProvider: provider)
        
        // when
        builder.email = testEmail
        builder.password = testPassword
        sut.logIn()
        
        // then
        XCTAssertNotNil(provider.alert)
        XCTAssert(alertTitle == provider.alert?.title)
    }
    
    func test_givenInvalidPassword_whenLogIn_thenLogInWithIsNotCalled() {
        // given
        let testEmail = "test@gmail.com"
        let testPassword = "Test"
        let loginController = LoginControllerDummy()
        let builder = LoginBuilderDummy()
        setUpTests(loginBuilder: builder, loginController: loginController)
        
        // when
        builder.email = testEmail
        builder.password = testPassword
        sut.logIn()
        
        // then
        XCTAssertNil(loginController.isLogedIn)
    }
    
    private class LoginBuilderDummy: LoginBuilder {
        var email: String?
        var password: String?
        
        var isMandatoryDataFilled: Bool {
            guard let email = email, let password = password else { return false }
            return !email.isEmpty && !password.isEmpty
        }
        
        var isEmailValid: Bool {
            guard let email = email else { return false }
            return email.isEmail
        }
        
        var isPasswordValid: Bool {
            guard let password = password else { return false }
            return password.containsNumber && password.containsCapital && password.length > 7
        }
        
        func build() throws -> LoginCredentials {
            guard let email = email, let password = password else { throw LoginBuilderError.missingMandatoryData }
            guard isEmailValid else { throw LoginBuilderError.invalidEmail }
            guard isPasswordValid else { throw LoginBuilderError.invalidPassword }
            return LoginCredentials(email: email, password: password)
        }
    }
    
    private class LoginViewDummy: TestView, LoginView {
        var isLoginEnbaledCalled: Bool?
        var isLoginEnabled: Bool?
        
        func isLoginEnabled(_ isEnabled: Bool) {
            isLoginEnbaledCalled = true
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
