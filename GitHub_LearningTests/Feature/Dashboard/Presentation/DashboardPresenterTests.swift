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
        dashboardController: DashboardController = DashboardControllerDummy(),
        logOutController: LogOutController = LogOutControllerDummy(),
        dashboardView: DashboardView = DashboardViewDummy()
    ) {
        sut = DashboardPresenterImpl(dashboardCotroller: dashboardController, logOutController: logOutController)
        sut.view = dashboardView
    }
    
    func test_givenDashboardView_whenViewDidLoad_thenSetEmailIsCalled() {
        // Given
        let view = DashboardViewDummy()
        setupTests(dashboardView: view)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(view.isSetEmailCalled == true)
    }
    
    func test_givenTestEmail_whenViewDidLoad_thenTestEmailEqualsViewsEmail() {
        // Given
        let testEmail = "test@gmail.com"
        let dashboardController = DashboardControllerDummy(email: testEmail)
        let view = DashboardViewDummy()
        setupTests(dashboardController: dashboardController, dashboardView: view)
        
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
    
    func test_givenCryptocurrency_whenCryptocurrencyIsSet_thenIsNotifiedAndSetCryptocurrencyMethodsAreCalled() {
        // Given
        let dashboardController = DashboardControllerDummy()
        let view = DashboardViewDummy()
        let cryptocurrency = Cryptocurrency(imageUrl: "Dummy", symbol: "Dummy", priceChange: 0, price: 0)
        setupTests(dashboardController: dashboardController, dashboardView: view)
        sut.viewDidLoad()
        
        // When
        dashboardController.cryptocurrency = cryptocurrency
        
        // Then
        XCTAssert(view.isCryptocurrencyImageSet == true)
        XCTAssert(view.isCryptocurrencyPriceSet == true)
        XCTAssert(view.isCryptocurrencyPriceChangeSet == true)
        XCTAssert(view.isCryptocurrencySymbolSet == true)
    }
    
    func test_givenValidPriceChange_thenPriceChangeContainsPercatangeSign() {
        // Given
        let dashboardController = DashboardControllerDummy()
        let view = DashboardViewDummy()
        let cryptocurrency = Cryptocurrency(imageUrl: "Dummy", symbol: "Dummy", priceChange: 1, price: 0)
        setupTests(dashboardController: dashboardController, dashboardView: view)
        sut.viewDidLoad()
        dashboardController.cryptocurrency = cryptocurrency
        
        // Then
        XCTAssert((view.priceChange ?? "").contains("%"))
    }
    
    func test_givenPriceChangeIsGreaterThanZero_whenCryptocurrencyIsSet_thenPriceChangeDirectionIsPositive() {
        // Given
        let dashboardController = DashboardControllerDummy()
        let view = DashboardViewDummy()
        let cryptocurrency = Cryptocurrency(imageUrl: "Dummy", symbol: "Dummy", priceChange: 1, price: 0)
        setupTests(dashboardController: dashboardController, dashboardView: view)
        sut.viewDidLoad()
        
        // When
        dashboardController.cryptocurrency = cryptocurrency
        
        // Then
        XCTAssert(view.direction == .positive)
        XCTAssert((view.priceChange ?? "").contains("+"))
    }
    
    func test_givenPriceChangeIsLessThanZero_whenCryptocurrencyIsSet_thenPriceChangeDirectionIsNegative() {
        // Given
        let dashboardController = DashboardControllerDummy()
        let view = DashboardViewDummy()
        let cryptocurrency = Cryptocurrency(imageUrl: "Dummy", symbol: "Dummy", priceChange: -1, price: 0)
        setupTests(dashboardController: dashboardController, dashboardView: view)
        sut.viewDidLoad()
        
        // When
        dashboardController.cryptocurrency = cryptocurrency
        
        // Then
        XCTAssert(view.direction == .negative)
    }
    
    func test_givenPriceChangeIsZero_whenCryptocurrencyIsSet_thenPriceChangeDirectionIsNeutral() {
        // Given
        let dashboardController = DashboardControllerDummy()
        let view = DashboardViewDummy()
        let cryptocurrency = Cryptocurrency(imageUrl: "Dummy", symbol: "Dummy", priceChange: 0, price: 0)
        setupTests(dashboardController: dashboardController, dashboardView: view)
        sut.viewDidLoad()
        
        // When
        dashboardController.cryptocurrency = cryptocurrency
        
        // Then
        XCTAssert(view.direction == .neutral)
        XCTAssert((view.priceChange ?? "").contains("+"))
    }
    
    func test_givenNilPriceChange_thenPriceChangeDirectionIsNeutral() {
        // Given
        let dashboardController = DashboardControllerDummy()
        let view = DashboardViewDummy()
        let priceChange: Double? = nil
        let cryptocurrency = Cryptocurrency(imageUrl: "Dummy", symbol: "Dummy", priceChange: priceChange, price: 0)
        setupTests(dashboardController: dashboardController, dashboardView: view)
        sut.viewDidLoad()
        
        // When
        dashboardController.cryptocurrency = cryptocurrency
        
        // Then
        XCTAssert(view.direction == .neutral)
        XCTAssert(view.priceChange?.contains("N&N") ?? false)
    }
    
    private class DashboardControllerDummy: TestController, DashboardController {
        var cryptocurrency: Cryptocurrency? {
            didSet {
                notifyListenersAboutUpdate()
            }
        }
        
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
        var isCryptocurrencyPriceSet: Bool?
        var isCryptocurrencyPriceChangeSet: Bool?
        var isCryptocurrencyImageSet: Bool?
        var isCryptocurrencySymbolSet: Bool?
        var direction: PriceChangeDirection?
        var priceChange: String?
        
        var email: String?
        var isSetEmailCalled: Bool?
        
        func setCryptocurrencyPrice(_ price: String) {
            isCryptocurrencyPriceSet = true
        }
        func setCryptocurrencyPriceChange(_ change: String?, direction: PriceChangeDirection) {
            isCryptocurrencyPriceChangeSet = true
            self.direction = direction
            priceChange = change
        }
        func setCryptocurrencyImage(_ image: URL?) {
            isCryptocurrencyImageSet = true
        }
        func setCryptocurrencySymbol(_ symbol: String) {
            isCryptocurrencySymbolSet = true
        }
        func setEmail(_ email: String?) {
            self.email = email
            isSetEmailCalled = true
        }
    }
}
