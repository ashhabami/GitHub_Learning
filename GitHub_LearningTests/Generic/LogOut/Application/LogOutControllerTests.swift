//
//  LogOutControllerTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 16.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import XCTest
import CleanCore
@testable import GitHub_Learning

class LogOutControllerTests: XCTestCase {
    var sut: LogOutControllerImpl!
    
    func setUpTest(
        wireframe: Wireframe = WireframeDummy(),
        credentailKeychainController: CredentialKeychainController = CredentailKeychainControllerDummy()
    ) {
       sut = LogOutControllerImpl(wireframe: wireframe, credentialKeychainController: credentailKeychainController)
    }
    
    func test_givenLogOutController_whenLogOut_thenLaunchLogin() {
        // Given
        let wireframe = WireframeDummy()
        setUpTest(wireframe: wireframe)
        
        // When
        sut.logOut()
        
        // Then
        XCTAssert(wireframe.loginLaunched == true)
        XCTAssert(wireframe.loginLaunchPoint == LoginLaunchPoint.dashboard)
    }
    
    func test_givenLogOutController_whenLogOut_thenCredentailsAreDeleted() {
        // Given
        let controller = CredentailKeychainControllerDummy()
        setUpTest(credentailKeychainController: controller)
        
        // When
        sut.logOut()
        
        // Then
        XCTAssert(controller.credentailsDeleted == true)
    }
    
    private class WireframeDummy: Wireframe {
        var loginLaunchPoint: LoginLaunchPoint?
        var loginLaunched: Bool?
        
        func launchLoginAfter(_ point: LoginLaunchPoint) {
            loginLaunched = true
            loginLaunchPoint = point
        }
        func launchAlertWith(_ title: String, message: String, actions: [AlertAction]?) {}
        func setOnboardingAsRoot() {}
        func launchDashboard(from point: DashboardLaunchPoint) {}
    }
    
    private class CredentailKeychainControllerDummy: TestController, CredentialKeychainController {
        var credentailsDeleted: Bool?
            
        func deleteCredentials() {
            credentailsDeleted = true
        }
        func storeCredentials(_ credentials: String) {}
        func loadCredentials(_ completion: @escaping (Result<LoadCredentialsKeychainResponse>) -> Void) {}
    }
}
