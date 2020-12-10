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
    private var loadFinishedFacade: LoadOnboardingFinishedFacade!
    private var keychainController: CredentialKeychainController!
    private var loginLauncher: LoginLauncherController!
    private var wf: Wireframe!
    private var dashboardLauncher: DashboardLauncherController!
    
    private func setUpTests(
        loadOnboardingFinishedFacade: LoadOnboardingFinishedFacade? = nil,
        credentialKeychainController: CredentialKeychainController? = nil,
        wireframe: Wireframe? = nil,
        loginLauncherController: LoginLauncherController? = nil,
        dashboardLauncherController: DashboardLauncherController? = nil
    ) {
        self.loadFinishedFacade = loadOnboardingFinishedFacade ?? LoadOnboardingFinishedFacadeDummy()
        self.keychainController = credentialKeychainController ?? CredentialKeychainControllerDummy()
        self.loginLauncher = loginLauncherController ?? LoginLauncherControllerDummy()
        self.wf = wireframe ?? TestWireframe()
        self.dashboardLauncher = dashboardLauncherController ?? DashboardLauncherControllerDummy()
        sut = StartUpControllerImpl(
            loadOnboardingFinishedFacade: loadFinishedFacade,
            loginLauncherController: loginLauncher,
            credentialKeychainController: keychainController,
            dashboardLauncherController: dashboardLauncher,
            wireframe: wf)
    }
    
    func test_givenLoadOnboardingFinishedFacadeIsCalledWithSuccessAndResponseIsTrue_whenStartUpIsCalled_thenLoadCredentialsIsCalled() {
        // given
        let facade = LoadOnboardingFinishedFacadeSuccessTrueStub()
        let credentialKeychainController = CredentialKeychainControllerDummy()
        setUpTests(loadOnboardingFinishedFacade: facade, credentialKeychainController: credentialKeychainController)
        
        // when
        sut.startUp()
        
        //Then
        XCTAssertNotNil(credentialKeychainController.isLoaded)
        XCTAssert(credentialKeychainController.isLoaded == true)
    }
    
    func test_givenLoadOnboardingFinishedFacadeCallWithSuccessAndResponseIsFalse_whenStartUpIsCalled_thenSetOnboardingAsRootIsCalled() {
        // given
        let facade = LoadOnboardingFinishedFacadeSuccessFalseStub()
        let credentialKeychainController = CredentialKeychainControllerDummy()
        let wireframe = TestWireframe()
        setUpTests(loadOnboardingFinishedFacade: facade, credentialKeychainController: credentialKeychainController,wireframe: wireframe)
        
        // when
        sut.startUp()
        
        //Then
        XCTAssertNotNil(wireframe.isOnboardingSetAsRoot)
        XCTAssert(wireframe.isOnboardingSetAsRoot == true)
    }
    
    func test_givenLoadOnboardingFinishedFacadeCallWithFailure_whenStartUpIsCalled_thenSetOnboardingAsRootIsCalled() {
        // given
        let facade = LoadOnboardingFinishedFacadeFailureStub()
        let credentialKeychainController = CredentialKeychainControllerDummy()
        let wireframe = TestWireframe()
        setUpTests(loadOnboardingFinishedFacade: facade, credentialKeychainController: credentialKeychainController,wireframe: wireframe)
        
        // when
        sut.startUp()
        
        //Then
        XCTAssertNotNil(wireframe.isOnboardingSetAsRoot)
        XCTAssert(wireframe.isOnboardingSetAsRoot == true)
    }
    
    func test_givenLoadCredentailsIsCalledWithSuccess_whenStartUpIsCalled_thenDashboardLauncherCallsLaunchDashboardWith() {
        // given
        let facade = LoadOnboardingFinishedFacadeSuccessTrueStub()
        let credentialKeychainController = CredentialKeychainControllerSuccessStub()
        let dashboardLauncherController = DashboardLauncherControllerDummy()
        setUpTests(
            loadOnboardingFinishedFacade: facade,
            credentialKeychainController: credentialKeychainController,
            dashboardLauncherController: dashboardLauncherController
        )
        
        // when
        sut.startUp()
        
        //Then
        XCTAssertNotNil(dashboardLauncherController.launched)
        XCTAssert(dashboardLauncherController.launched == true)
        XCTAssert(dashboardLauncherController.email == credentialKeychainController.loadedCredentials)
        XCTAssert(dashboardLauncherController.point == DashboardLaunchPoint.startUp)
    }
    
    func test_givenLoadCredentailsIsCalledWithFailure_whenStartUpIsCalled_thenLoginLauncherCallsLaunchLoginAfter() {
        // given
        let facade = LoadOnboardingFinishedFacadeSuccessTrueStub()
        let credentialKeychainController = CredentialKeychainControllerFailureStub()
        let loginLauncherController = LoginLauncherControllerDummy()
        setUpTests(
            loadOnboardingFinishedFacade: facade,
            credentialKeychainController: credentialKeychainController,
            loginLauncherController: loginLauncherController
        )
        
        // when
        sut.startUp()
        
        //Then
        XCTAssert(credentialKeychainController.isLoaded == false)
        XCTAssertNotNil(loginLauncherController.launched)
        XCTAssert(loginLauncherController.launched == true)
        XCTAssert(loginLauncherController.point == LoginLaunchPoint.start)
    }
    
    private class LoadOnboardingFinishedFacadeDummy: LoadOnboardingFinishedFacade {
        func load(_ request: LoadOnboardingFinishedRequest, completion: @escaping ((Result<LoadOnboardingFinishedResponse>) -> Void)) {}
    }
    
    private class LoadOnboardingFinishedFacadeSuccessTrueStub: LoadOnboardingFinishedFacade {
        func load(_ request: LoadOnboardingFinishedRequest, completion: @escaping ((Result<LoadOnboardingFinishedResponse>) -> Void)) {
            completion(.success(response: LoadOnboardingFinishedResponse(isFinished: true)))
        }
    }
    
    private class LoadOnboardingFinishedFacadeSuccessFalseStub: LoadOnboardingFinishedFacade {
        func load(_ request: LoadOnboardingFinishedRequest, completion: @escaping ((Result<LoadOnboardingFinishedResponse>) -> Void)) {
            completion(.success(response: LoadOnboardingFinishedResponse(isFinished: false)))
        }
    }
    
    private class LoadOnboardingFinishedFacadeFailureStub: LoadOnboardingFinishedFacade {
        func load(_ request: LoadOnboardingFinishedRequest, completion: @escaping ((Result<LoadOnboardingFinishedResponse>) -> Void)) {
            completion(.failure(error: LocalStorageError.loadFailed("Load Failed")))
        }
    }
    
    private class CredentialKeychainControllerDummy: TestController, CredentialKeychainController {
        var isLoaded: Bool?
    
        func storeCredentials(_ credintals: String) {}
        func deleteCredentials() {}
        
        func loadCredentials(_ completion: @escaping (Result<LoadCredentialsKeychainResponse>) -> Void) {
            isLoaded = true
        }
    }
    
    private class CredentialKeychainControllerSuccessStub: TestController, CredentialKeychainController {
        var isLoaded: Bool?
        var loadedCredentials: String?
    
        func storeCredentials(_ credintals: String) {}
        func deleteCredentials() {}
        
        func loadCredentials(_ completion: @escaping (Result<LoadCredentialsKeychainResponse>) -> Void) {
            isLoaded = true
            let credentials = "Success"
            self.loadedCredentials = credentials
            completion(.success(response: LoadCredentialsKeychainResponse(credentials: credentials)))
        }
    }
    
    private class CredentialKeychainControllerFailureStub: TestController, CredentialKeychainController {
        var isLoaded: Bool?
        var loadedCredentials: String?
    
        func storeCredentials(_ credintals: String) {}
        func deleteCredentials() {}
        
        func loadCredentials(_ completion: @escaping (Result<LoadCredentialsKeychainResponse>) -> Void) {
            isLoaded = false
            completion(.failure(error: LocalStorageError.loadFailed("Load Failed")))
        }
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
    
    private class TestWireframe: Wireframe {
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
