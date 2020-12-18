//
//  AlertProviderControllerTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 17.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import XCTest
@testable import GitHub_Learning

class AlertProviderControllerTests: XCTestCase {
    private var sut: AlertProviderControllerImpl!
   
    private func setUpTests(
        wireframe: Wireframe = WireframeDummy()
    ) {
        sut = AlertProviderControllerImpl(wireframe: wireframe)
    }
    
    func test_givenAlertProvider_whenShowAlertWith_thenLaunchAlertWithIsCalled() {
        // Given
        let wireframe = WireframeDummy()
        setUpTests(wireframe: wireframe)
        
        // When
        sut.showAlertWith("Dummy", message: "Dummy", actions: nil)
        
        // Then
        XCTAssert(wireframe.alertLaunched == true)
    }
 
    private class WireframeDummy: Wireframe {
        var alertLaunched: Bool?
        
        func launchAlertWith(_ title: String, message: String, actions: [AlertAction]?) {
            alertLaunched = true
        }
        func launchLoginAfter(_ point: LoginLaunchPoint) {}
        func setOnboardingAsRoot() {}
        func launchDashboard(from point: DashboardLaunchPoint) {}
    }
}
