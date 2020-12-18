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
    
    func test_givenOnboardingResource_whenloadIsOnboardingFinished_thenDataAreLoaded() throws {
        // Given
        let localStorage = LocalStorageDummy()
        let isFinished = true
        localStorage.dataLoaded = isFinished
        setUpTests(localStorage: localStorage)
        
        // When
        let data = try sut.loadIsOnboardingFinished()
        
        // Then
        XCTAssert(isFinished == data)
    }
    
    func test_givenOnboardingResource_whenStoreIsOnboardingFinished_thenDataAreStored() {
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
            isOnboardingFinished = try fromByteArray(data, Bool.self)
        }
        
        func loadData(_ type: String, id: String) throws -> Bytes {
            return toByteArray(dataLoaded)
        }
        
        func deleteData(_ type: String, id: String) throws {}
        
        private func fromByteArray<T>(_ value: Bytes, _ type: T.Type) throws -> T {
            return try value.withUnsafeBytes {
                guard let baseAddress = $0.baseAddress else { throw LocalStorageError.loadFailed("\(#function)") }
                return baseAddress.load(as: type)
            }
        }
    
        private func toByteArray<T>(_ value: T) -> Bytes {
            var value = value
            return withUnsafeBytes(of: &value) { Array($0) }
        }
    }
}
