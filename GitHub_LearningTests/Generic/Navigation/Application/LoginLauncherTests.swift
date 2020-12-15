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
    
    func test_givenLoginLauncherController_whenlaunchLoginAfter_thenWireframeCallslaunchLoginAfter() {
        // Given
        let wireframe = WireframeDummy()
        setupTest(wireframe: wireframe)
        
        // When
        sut.launchLoginAfter(.start)
        
        // Then
        XCTAssert(wireframe.isLoginLaunchedCalled == true)
    }
    
    private class WireframeDummy: Wireframe {
        var isLoginLaunchedCalled: Bool?
        
        func launchLoginAfter(_ point: LoginLaunchPoint) {
            isLoginLaunchedCalled = true
        }
        func launchAlertWith(_ title: String, message: String, actions: [AlertAction]?) {}
        func setOnboardingAsRoot() {}
        func launchDashboard(from point: DashboardLaunchPoint) {}
    }
}
