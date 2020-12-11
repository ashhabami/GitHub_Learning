//
//  StartUpTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 07.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import XCTest
import CleanCore
@testable import GitHub_Learning

class StartUpControllerTests: XCTestCase {
    private var sut: StartUpControllerImpl!
    
    private func setUpTests(
        loadOnboardingFinishedFacade: LoadOnboardingFinishedFacade = LoadOnboardingFinishedFacadeDummy(),
        loginLauncherController: LoginLauncherController = LoginLauncherControllerDummy(),
        credentialKeychainController: CredentialKeychainController = CredentialKeychainControllerDummy(),
        dashboardLauncherController: DashboardLauncherController = DashboardLauncherControllerDummy(),
        wireframe: Wireframe = WireframeDummy()
    ) {
        sut = StartUpControllerImpl(
            loadOnboardingFinishedFacade: loadOnboardingFinishedFacade,
            loginLauncherController: loginLauncherController,
            credentialKeychainController: credentialKeychainController,
            dashboardLauncherController: dashboardLauncherController,
            wireframe: wireframe
        )
    }
    
    func test_givenOnboardingIsFinished_whenStartUpIsCalled_thenLoadCredentialsIsCalled() {
        // Given
        let returnValue = onboardingFinishedResult(true)
        let facade = LoadOnboardingFinishedFacadeDummy(returnValue: returnValue)
        let credentialKeychainController = CredentialKeychainControllerDummy()
        setUpTests(loadOnboardingFinishedFacade: facade, credentialKeychainController: credentialKeychainController)
        
        // When
        sut.startUp()
        
        // Then
        XCTAssertNotNil(credentialKeychainController.isCalled)
        XCTAssert(credentialKeychainController.isCalled == true)
    }
    
    func test_givenOnboardingIsNotFinished_whenStartUpIsCalled_thenSetOnboardingAsRootIsCalled() {
        // Given
        let returnValue = onboardingFinishedResult(false)
        let facade = LoadOnboardingFinishedFacadeDummy(returnValue: returnValue)
        let wireframe = WireframeDummy()
        setUpTests(loadOnboardingFinishedFacade: facade, wireframe: wireframe)
        
        // When
        sut.startUp()
        
        // Then
        XCTAssertNotNil(wireframe.isOnboardingSetAsRoot)
        XCTAssert(wireframe.isOnboardingSetAsRoot == true)
    }
    
    func test_givenLoadOnboardingFails_whenStartUpIsCalled_thenSetOnboardingAsRootIsCalled() {
        // Given
        let error = LocalStorageError.loadFailed("Load Failed")
        let returnValue = onboardingFailureResult(error)
        let facade = LoadOnboardingFinishedFacadeDummy(returnValue: returnValue)
        let wireframe = WireframeDummy()
        setUpTests(loadOnboardingFinishedFacade: facade, wireframe: wireframe)
        
        // When
        sut.startUp()
        
        // Then
        XCTAssertNotNil(wireframe.isOnboardingSetAsRoot)
        XCTAssert(wireframe.isOnboardingSetAsRoot == true)
    }
    
    func test_givenLoadCredentailsIsCalledWithSuccess_whenStartUpIsCalled_thenDashboardLauncherCallsLaunchDashboardWith() {
        // Given
        let facade = LoadOnboardingFinishedFacadeDummy(returnValue: onboardingFinishedResult(true))
        let email = "success@gmail.com"
        let returnValue = credentailsLoadedSuccessResult(email)
        let credentialKeychainController = CredentialKeychainControllerDummy(returnValue: returnValue)
        let dashboardLauncherController = DashboardLauncherControllerDummy()
        setUpTests(
            loadOnboardingFinishedFacade: facade,
            credentialKeychainController: credentialKeychainController,
            dashboardLauncherController: dashboardLauncherController
        )
        
        // When
        sut.startUp()
        
        // Then
        XCTAssertNotNil(dashboardLauncherController.launched)
        XCTAssert(dashboardLauncherController.launched == true)
        XCTAssert(dashboardLauncherController.email == email)
        XCTAssert(dashboardLauncherController.point == DashboardLaunchPoint.startUp)
    }
    
    func test_givenLoadCredentailsIsCalledWithFailure_whenStartUpIsCalled_thenLoginLauncherCallsLaunchLoginAfter() {
        // Given
        let facade = LoadOnboardingFinishedFacadeDummy(returnValue: onboardingFinishedResult(true))
        let loginLauncherController = LoginLauncherControllerDummy()
        let returnValue = credentailsLoadedFailureResult(LocalStorageError.loadFailed("Load Failed"))
        let credentialKeychainController = CredentialKeychainControllerDummy(returnValue: returnValue)
        setUpTests(
            loadOnboardingFinishedFacade: facade,
            loginLauncherController: loginLauncherController,
            credentialKeychainController: credentialKeychainController
        )
        
        // When
        sut.startUp()
        
        // Then
        XCTAssert(credentialKeychainController.isCalled == true)
        XCTAssert(credentialKeychainController.isLoaded == false)
        XCTAssertNotNil(loginLauncherController.launched)
        XCTAssert(loginLauncherController.launched == true)
        XCTAssert(loginLauncherController.point == LoginLaunchPoint.start)
    }
    
    private class LoadOnboardingFinishedFacadeDummy: LoadOnboardingFinishedFacade {
        private let returnValue: Result<LoadOnboardingFinishedResponse>?

        init(returnValue: Result<LoadOnboardingFinishedResponse>? = nil) {
            self.returnValue = returnValue
        }
        
        func load(_ request: LoadOnboardingFinishedRequest, completion: @escaping ((Result<LoadOnboardingFinishedResponse>) -> Void)) {
            if let returnValue = returnValue {
                completion(returnValue)
            }
        }
    }
    
    private func onboardingFinishedResult(_ isFinished: Bool) -> Result<LoadOnboardingFinishedResponse> {
        .success(response: LoadOnboardingFinishedResponse(isFinished: isFinished))
    }
    
    private func onboardingFailureResult(_ error: Error) -> Result<LoadOnboardingFinishedResponse> {
        .failure(error: error)
    }
    
    private class CredentialKeychainControllerDummy: TestController, CredentialKeychainController {
        var isCalled: Bool?
        var isLoaded: Bool?
        private let returnValue: Result<LoadCredentialsKeychainResponse>?
        
        init(returnValue: Result<LoadCredentialsKeychainResponse>? = nil) {
            self.returnValue = returnValue
        }
    
        func storeCredentials(_ credintals: String) {}
        func deleteCredentials() {}
        
        func loadCredentials(_ completion: @escaping (Result<LoadCredentialsKeychainResponse>) -> Void) {
            if let returnValue = returnValue {
                switch returnValue {
                case .success:
                    isCalled = true
                    isLoaded = true
                case .failure:
                    isCalled = true
                    isLoaded = false
                }
                completion(returnValue)
            } else {
                isCalled = true
            }
        }
    }
    
    private func credentailsLoadedSuccessResult(_ credentails: String) -> Result<LoadCredentialsKeychainResponse> {
        .success(response: LoadCredentialsKeychainResponse(credentials: credentails) )
    }
    
    private func credentailsLoadedFailureResult(_ error: Error) -> Result<LoadCredentialsKeychainResponse> {
        .failure(error: error)
    }
    
    
    private class LoginLauncherControllerDummy: TestController, LoginLauncherController {
        var launched: Bool?
        var point: LoginLaunchPoint?

        func launchLoginAfter(_ point: LoginLaunchPoint) {
            launched = true
            self.point = point
        }
    }
    
    private class DashboardLauncherControllerDummy: TestController, DashboardLauncherController {
        var launched: Bool?
        var email: String?
        var point: DashboardLaunchPoint?
        
        func launchDashboardWith(_ email: String, from launchPoint: DashboardLaunchPoint) {
            launched = true
            self.email = email
            self.point = launchPoint
        }
    }
    
    private class WireframeDummy: Wireframe {
        var isOnboardingSetAsRoot: Bool?
        
        func launchLoginAfter(_ point: LoginLaunchPoint) {}
        
        func launchAlertWith(_ title: String, message: String, actions: [AlertAction]?) {}
        
        func setOnboardingAsRoot() {
            isOnboardingSetAsRoot = true
        }
        
        func launchDashboard(from point: DashboardLaunchPoint) {
            
        }
    }
}
