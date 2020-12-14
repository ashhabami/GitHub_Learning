//
//  DashboardPresenterTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 14.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import XCTest
@testable import GitHub_Learning

class DashboardPresenterTests: XCTestCase {
    private var sut: DashboardPresenterImpl!
    
    private func setupTests(
        dashboardCotroller: DashboardController = DashboardControllerDummy(),
        logOutController: LogOutController = LogOutControllerDummy(),
        dashboardView: DashboardView = DashboardViewDummy()
    ) {
        sut = DashboardPresenterImpl(dashboardCotroller: dashboardCotroller, logOutController: logOutController)
        sut.view = dashboardView
    }
    
    func test_givenDashboardView_whenViewDidLoad_thenSetEmailIsCalled() {
        // Given
        let view = DashboardViewDummy()
        setupTests(dashboardView: view)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(view.isCalled == true)
    }
    
    func test_givenTestEmail_whenViewDidLoad_thenTestEmailEqualsViewsEmail() {
        // Given
        let testEmail = "test@gmail.com"
        let dashboardController = DashboardControllerDummy(email: testEmail)
        let view = DashboardViewDummy()
        setupTests(dashboardCotroller: dashboardController, dashboardView: view)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(view.email == testEmail)
    }
    
    func test_givenLogOutController_whenLogOut_thenLogOutControllerLogsOut() {
        // Given
        let logOutController = LogOutControllerDummy()
        setupTests(logOutController: logOutController)
        
        // When
        sut.logOut()
        
        // Then
        XCTAssert(logOutController.isLogedOut == true)
    }
    
    private class DashboardControllerDummy: TestController, DashboardController {
        private var email: String?
        
        init(email: String = "Initial Value") {
            self.email = email
        }
        
        func setEmail(_ email: String) {
            self.email = email
        }
        
        func getEmail() -> String? {
            return email
        }
    }
    
    private class LogOutControllerDummy: TestController, LogOutController {
        var isLogedOut: Bool?
        
        func logOut() {
            isLogedOut = true
        }
    }
    
    private class DashboardViewDummy: TestView, DashboardView {
        var email: String?
        var isCalled: Bool?
        
        func setEmail(_ email: String?) {
            self.email = email
            isCalled = true
        }
    }
}
