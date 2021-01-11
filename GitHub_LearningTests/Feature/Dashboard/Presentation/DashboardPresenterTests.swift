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
    
    func test_givenDashboardController_whenViewDidLoad_thenDashboardControllerCallsLoadCrypto() {
        // Given
        let controller = DashboardControllerDummy()
        setupTests(dashboardController: controller)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(controller.cryptoLoaded == true)
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
    
    func test_givenCryptocurrency_whenCryptocurrencyIsSet_thenIsNotifiedAndSetCryptocurrencyIsCalled() {
        // Given
        let dashboardController = DashboardControllerDummy()
        let view = DashboardViewDummy()
        let cryptocurrencies = [Cryptocurrency(imageUrl: "Dummy", symbol: "Dummy", priceChange: 0, price: 0, rank: 0)]
        setupTests(dashboardController: dashboardController, dashboardView: view)
        sut.viewDidLoad()
        
        // When
        dashboardController.cryptocurrencies = cryptocurrencies
        
        // Then
        XCTAssert(view.isCryptocurenciesSet == true)
    }
    
    func test_givenValidPriceChange_whenCryptocurrencyIsSet_thenPriceChangeContainsPercatangeSign() {
        // Given
        let dashboardController = DashboardControllerDummy()
        let view = DashboardViewDummy()
        let cryptocurrencies = [Cryptocurrency(imageUrl: "Dummy", symbol: "Dummy", priceChange: 0, price: 0, rank: 0)]
        setupTests(dashboardController: dashboardController, dashboardView: view)
        sut.viewDidLoad()
        
        // When
        dashboardController.cryptocurrencies = cryptocurrencies
        
        // Then
        XCTAssert(view.priceChange?.contains("%") ?? false)
    }
    
    func test_givenPriceChangeIsGreaterThanZero_whenCryptocurrencyIsSet_thenPriceChangeDirectionIsPositive() {
        // Given
        let dashboardController = DashboardControllerDummy()
        let view = DashboardViewDummy()
        let cryptocurrencies = [Cryptocurrency(imageUrl: "Dummy", symbol: "Dummy", priceChange: 1, price: 0, rank: 0)]
        setupTests(dashboardController: dashboardController, dashboardView: view)
        sut.viewDidLoad()
        
        // When
        dashboardController.cryptocurrencies = cryptocurrencies
        
        // Then
        XCTAssert(view.direction == .positive)
        XCTAssert(view.priceChange?.contains("+") ?? false)
    }
    
    func test_givenPriceChangeIsLessThanZero_whenCryptocurrencyIsSet_thenPriceChangeDirectionIsNegative() {
        // Given
        let dashboardController = DashboardControllerDummy()
        let view = DashboardViewDummy()
        let cryptocurrencies = [Cryptocurrency(imageUrl: "Dummy", symbol: "Dummy", priceChange: 0, price: 0, rank: 0)]
        setupTests(dashboardController: dashboardController, dashboardView: view)
        sut.viewDidLoad()
        
        // When
        dashboardController.cryptocurrencies = cryptocurrencies
        
        // Then
        XCTAssert(view.direction == .negative)
        XCTAssertFalse(view.priceChange?.contains("+") ?? true)
    }
    
    func test_givenNilPriceChange_thenPriceChangeDirectionIsNeutral() {
        // Given
        let dashboardController = DashboardControllerDummy()
        let view = DashboardViewDummy()
        let priceChange: Double? = nil
        let cryptocurrencies = [Cryptocurrency(imageUrl: "Dummy", symbol: "Dummy", priceChange: priceChange, price: 0, rank: 0)]
        setupTests(dashboardController: dashboardController, dashboardView: view)
        sut.viewDidLoad()
        
        // When
        dashboardController.cryptocurrencies = cryptocurrencies
        
        // Then
        XCTAssert(view.direction == .neutral)
        XCTAssert(view.priceChange?.contains("N&N") ?? false)
    }
    
    func test_givenDashboardPresenter_whenRefresh_thenCryptoIsLoaded() {
        // Given
        let dashboardController = DashboardControllerDummy()
        setupTests(dashboardController: dashboardController)
        
        // When
        sut.refresh()
        
        // Then
        XCTAssert(dashboardController.cryptoLoaded == true)
    }
    
    private class DashboardControllerDummy: TestController, DashboardController {
        var cryptocurrencies = [Cryptocurrency]() {
            didSet {
                notifyListenersAboutUpdate()
            }
        }
        
        var cryptoLoaded: Bool?
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
        
        func loadCrypto(_ completion: (() -> Void)?) {
            cryptoLoaded = true
        }
    }
    
    private class LogOutControllerDummy: TestController, LogOutController {
        var isLogedOut: Bool?
        
        func logOut() {
            isLogedOut = true
        }
    }
    
    private class DashboardViewDummy: TestView, DashboardView {
        var direction: PriceChangeDirection?
        var priceChange: String?
        var isCryptocurenciesSet: Bool?
        
        var email: String?
        var isSetEmailCalled: Bool?
        
        func setCryptocurrency(_ cryptocurrencies: [CryptocurrencyViewModel]) {
            isCryptocurenciesSet = true
            direction = cryptocurrencies.first?.priceChange
            priceChange = cryptocurrencies.first?.priceChangePercentage
        }
        
        func setEmail(_ email: String?) {
            self.email = email
            isSetEmailCalled = true
        }
    }
}
