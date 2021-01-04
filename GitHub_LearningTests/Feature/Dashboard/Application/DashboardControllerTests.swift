//
//  DashboardControllerTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 29.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import XCTest
import CleanCore
@testable import GitHub_Learning

class DashboardControllerTests: XCTestCase {
    private var sut: DashboardControllerImpl!
    
    private func setUpTests(
        cryptocurrencyPriceFacade: CryptocurrencyPriceFacade = CryptocurrencyPriceFacadeDummy()
    ) {
        sut = DashboardControllerImpl(cryptocurrencyPriceFacade: cryptocurrencyPriceFacade)
    }
    
    private func test_givenCryptocurrency_whenCryptocurrencyIsSet_thenNotifiesListeners() {
        // Given
        let cryptocurrency = Cryptocurrency(imageUrl: "Dummy", symbol: "Dummy", priceChange: 0.0, price: 0)
        let fakeListener = FakeListener()
        setUpTests()
        sut.subscribe(fakeListener, errorBlock: nil, updateBlock: { _ in fakeListener.isNotified = true })
        
        // When
        sut.cryptocurrency = cryptocurrency
        
        // Then
        XCTAssert(fakeListener.isNotified == true)
    }
    
    private func test_givenSuccessResult_whenDashboardIsInitialized_thenCryptocurrencyIsLoaded() {
        // Given
        let successResult: Result<CryptocurrencyResponse> = .success(response: CryptocurrencyResponse(cryptocurrency: Cryptocurrency(imageUrl: "Dummy", symbol: "Dummy", priceChange: 0.0, price: 0)))
        
        // When
        setUpTests(cryptocurrencyPriceFacade: CryptocurrencyPriceFacadeDummy(returnValue: successResult))
        
        // Then
        XCTAssertNotNil(sut.cryptocurrency)
    }
    
    private func test_givenFailureResult_whenDashboardIsInitialized_thenCryptocurrencyIsNotLoaded() {
        // Given
        let successResult: Result<CryptocurrencyResponse> = .failure(error: TestError.InvalidResponse)
        
        // When
        setUpTests(cryptocurrencyPriceFacade: CryptocurrencyPriceFacadeDummy(returnValue: successResult))
        
        // Then
        XCTAssertNil(sut.cryptocurrency)
    }
    
    private class CryptocurrencyPriceFacadeDummy: CryptocurrencyPriceFacade {
        
        private let returnValue: Result<CryptocurrencyResponse>
        
        init(returnValue: Result<CryptocurrencyResponse> = .success(response: CryptocurrencyResponse(cryptocurrency: Cryptocurrency(imageUrl: "Dummy", symbol: "Dummy", priceChange: 0.0, price: 0)))) {
            self.returnValue = returnValue
        }
        
        func getCryptocurrencyPrice(completion: @escaping (Result<CryptocurrencyResponse>) -> Void) {
            completion(returnValue)
        }
    }
    
    private class FakeListener: Listener {
        var isNotified: Bool?
    }
    
    private enum TestError: Error {
        case InvalidResponse
    }
}
