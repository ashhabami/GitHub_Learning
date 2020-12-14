//
//  LoginControllerTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 14.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import XCTest
import CleanCore
@testable import GitHub_Learning

class LoginControllerTests: XCTestCase {
    private var sut: LoginControllerImpl!
    
    private func setupTest(
        dashboardLauncherControllerDummy: DashboardLauncherController = DashboardLauncherControllerDummy(),
        keychainController: CredentialKeychainController = KeychainControllerDummy()
    ) {
        sut = LoginControllerImpl(
            dashboardLauncherController: dashboardLauncherControllerDummy,
            keychainController: keychainController
        )
    }
    
    func test_givenTestEmail_whenLoginWith_thenStoreCredentailsIsCalled() {
        // given
        let testEmail = "test@gmail.com"
        let keychainController = KeychainControllerDummy()
        setupTest(keychainController: keychainController)
        // when
        sut.logInWith(testEmail)
        
        // then
        XCTAssert(keychainController.isStoreCalled == true)
        XCTAssert(keychainController.credentials == testEmail)
    }
    
    func test_givenTestEmail_whenLoginWith_thenLaunchDashboardWithIsCalled() {
        // given
        let testEmail = "test@gmail.com"
        let dashboardLauncher = DashboardLauncherControllerDummy()
        setupTest(dashboardLauncherControllerDummy: dashboardLauncher)
        // when
        sut.logInWith(testEmail)
        
        // then
        XCTAssert(dashboardLauncher.email == testEmail)
        XCTAssert(dashboardLauncher.launchPoint == .login)
      }
      
    private class DashboardLauncherControllerDummy: TestController, DashboardLauncherController {
        let launchPoint = DashboardLaunchPoint.login
        var email: String?
        
        func launchDashboardWith(_ email: String, from launchPoint: DashboardLaunchPoint) {
            self.email = email
        }
    }
    
    private class KeychainControllerDummy: TestController, CredentialKeychainController {
        var credentials: String?
        var isStoreCalled: Bool?
        
        func storeCredentials(_ credentials: String) {
            isStoreCalled = true
            self.credentials = credentials
        }
        
        func loadCredentials(_ completion: @escaping (Result<LoadCredentialsKeychainResponse>) -> Void) {}
        func deleteCredentials() {}
    }
}
