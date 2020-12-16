//
//  LoginLauncherTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 15.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import XCTest
@testable import GitHub_Learning

class LoginLauncherTests: XCTestCase {
    private var sut: LoginLauncherControllerImpl!
    
    private func setupTest(
        wireframe: Wireframe = WireframeDummy()
    ) {
        sut = LoginLauncherControllerImpl(wireframe: wireframe)
    }
    
    func test_givenLoginLauncherController_whenlaunchLoginAfterStart_thenWireframeCallslaunchLoginAfter() {
        // Given
        let launchPoint = LoginLaunchPoint.start
        let wireframe = WireframeDummy()
        setupTest(wireframe: wireframe)
        
        // When
        sut.launchLoginAfter(launchPoint)
        
        // Then
        XCTAssert(wireframe.isLoginLaunchedCalled == true)
        XCTAssert(launchPoint == wireframe.launchPoint)
    }
    
    func test_givenLoginLauncherController_whenlaunchLoginAfterOnboarding_thenWireframeCallslaunchLoginAfter() {
        // Given
        let launchPoint = LoginLaunchPoint.onboarding
        let wireframe = WireframeDummy()
        setupTest(wireframe: wireframe)
        
        // When
        sut.launchLoginAfter(launchPoint)
        
        // Then
        XCTAssert(wireframe.isLoginLaunchedCalled == true)
        XCTAssert(launchPoint == wireframe.launchPoint)
    }
    
    func test_givenLoginLauncherController_whenlaunchLoginAfterDashboard_thenWireframeCallslaunchLoginAfter() {
        // Given
        let launchPoint = LoginLaunchPoint.dashboard
        let wireframe = WireframeDummy()
        setupTest(wireframe: wireframe)
        
        // When
        sut.launchLoginAfter(launchPoint)
        
        // Then
        XCTAssert(wireframe.isLoginLaunchedCalled == true)
        XCTAssert(launchPoint == wireframe.launchPoint)
    }
    
    private class WireframeDummy: Wireframe {
        var isLoginLaunchedCalled: Bool?
        var launchPoint: LoginLaunchPoint?
        
        func launchLoginAfter(_ point: LoginLaunchPoint) {
            isLoginLaunchedCalled = true
            launchPoint = point
        }
        func launchAlertWith(_ title: String, message: String, actions: [AlertAction]?) {}
        func setOnboardingAsRoot() {}
        func launchDashboard(from point: DashboardLaunchPoint) {}
    }
}
