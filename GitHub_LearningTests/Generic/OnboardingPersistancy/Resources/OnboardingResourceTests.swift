//
//  OnboardingResourceTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 18.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import XCTest
import CleanCore
import CleanPlatform
@testable import GitHub_Learning

class OnboardingResourceTests: XCTestCase {
    private var sut: OnboardingResourceImpl!
    
    private func setUpTests(
        localStorage: LocalStorage = LocalStorageDummy()
    ) {
        sut = OnboardingResourceImpl(localStorage: localStorage)
    }
    
    func test_givenOnboardingResource_whenLoadIsOnboardingFinished_thenDataAreLoaded() throws {
        // Given
        let localStorage = LocalStorageDummy()
        setUpTests(localStorage: localStorage)
        
        // When
        let _ = try sut.loadIsOnboardingFinished()
        
        // Then
        XCTAssert(localStorage.dataLoaded == true)
    }
    
    func test_givenOnboardingResource_whenStoreIsOnboardingFinished_thenDataAreLoaded() {
        // Given
        let localStorage = LocalStorageDummy()
        let isFinished = true
        setUpTests(localStorage: localStorage)
        
        // When
        sut.storeIsOnboardingFinished(isFinished)
        
        // Then
        XCTAssert(localStorage.isOnboardingFinished == isFinished)
    }
    
    private class LocalStorageDummy: LocalStorage {
        var isOnboardingFinished: Bool?
        var dataLoaded: Bool?
        
        func storeData(_ type: String, id: String, data: Bytes) throws {
            isOnboardingFinished = true
        }
        
        func loadData(_ type: String, id: String) throws -> Bytes {
            dataLoaded = true
            return Bytes()
        }
        
        func deleteData(_ type: String, id: String) throws {}
    }
}
