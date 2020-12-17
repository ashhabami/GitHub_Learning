//
//  DashboardLauncherTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 15.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//
import XCTest
@testable import GitHub_Learning

class DashboardLauncherTests: XCTestCase {
    private var sut: DashboardLauncherControllerImpl!
    
    private func setupTest(
        wireframe: Wireframe = WireframeDummy(),
        dashboardController: DashboardController = DashboardControllerDummy()
    ) {
        sut = DashboardLauncherControllerImpl(wireframe: wireframe, dashboardController: dashboardController)
    }
    
    func test_givenDashboardLauncherController_whenlaunchDashboardFromStartUp_thenWireframeCallsLaunchDashboard() {
        // Given
        let wireframe = WireframeDummy()
        let launchPoint = DashboardLaunchPoint.startUp
        let testEmail = "test@gmail.com"
        setupTest(wireframe: wireframe)
        
        // When
        sut.launchDashboardWith(testEmail, from: launchPoint)
        
        // Then
        XCTAssert(wireframe.isLaunchedDashboardCalled == true)
        XCTAssert(wireframe.launchPoint == launchPoint)
    }
    
    func test_givenDashboardLauncherController_whenlaunchDashboardFromLogin_thenWireframeCallsLaunchDashboard() {
        // Given
        let wireframe = WireframeDummy()
        let launchPoint = DashboardLaunchPoint.login
        let testEmail = "test@gmail.com"
        setupTest(wireframe: wireframe)
        
        // When
        sut.launchDashboardWith(testEmail, from: launchPoint)
        
        // Then
        XCTAssert(wireframe.isLaunchedDashboardCalled == true)
        XCTAssert(wireframe.launchPoint == launchPoint)
    }
    
    func test_givenTestEmail_whenlaunchDashboard_thenEmailIsSetToDashboardController() {
        // Given
        let wireframe = WireframeDummy()
        let controller = DashboardControllerDummy()
        let testEmail = "test@gmail.com"
        setupTest(wireframe: wireframe,dashboardController: controller)
        
        // When
        sut.launchDashboardWith(testEmail, from: .startUp)
        
        // Then
        XCTAssert(controller.email == testEmail)
    }
    
    private class WireframeDummy: Wireframe {
        var isLaunchedDashboardCalled: Bool?
        var launchPoint: DashboardLaunchPoint?
        
        func launchDashboard(from point: DashboardLaunchPoint) {
            isLaunchedDashboardCalled = true
            launchPoint = point
        }
        
        func launchLoginAfter(_ point: LoginLaunchPoint) {}
        func launchAlertWith(_ title: String, message: String, actions: [AlertAction]?) {}
        func setOnboardingAsRoot() {}
    }
    
    private class DashboardControllerDummy: TestController, DashboardController {
        var email: String?
        
        func setEmail(_ email: String) {
            self.email = email
        }
        
        func getEmail() -> String? {
            return email
        }
    }
}
