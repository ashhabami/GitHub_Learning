//
//  CredentailsKeychainResourceTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 17.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import XCTest
import CleanCore
@testable import GitHub_Learning

class CredentailsKeychainResourceTests: XCTestCase {
    private var sut: CredentialsKeychainResourceImpl!
    
    private func setUpTests(
        localStorage: LocalStorage = LocalStorageDummy()
    ) {
        sut = CredentialsKeychainResourceImpl(keychain: localStorage)
    }
    
    func test_givenCredentails_whenStoreCredentails_thenStoreDataIsCalled() throws {
        // Given
        let credentails = "dummy"
        let storage = LocalStorageDummy()
        setUpTests(localStorage: storage)
        
        // When
        try sut.storeCredentials(credentails)
        
        // Then
        XCTAssert(storage.dataStored == credentails)
    }
    
    func test_givenKeychainResource_whenLoadCredentails_thenLoadDataIsCalled() throws {
        // Given
        let storage = LocalStorageDummy()
        setUpTests(localStorage: storage)
        
        // When
        let _ = try sut.loadCredentials()
        
        // Then
        XCTAssert(storage.dataLoaded == true)
    }
    
    func test_givenKeychainResource_whenDeleteCredentails_thenDeleteDataIsCalled() throws {
        // Given
        let storage = LocalStorageDummy()
        setUpTests(localStorage: storage)
        
        // When
        try sut.deleteCredentials()
        
        // Then
        XCTAssert(storage.dataDeleted == true)
    }
    
    private class LocalStorageDummy: LocalStorage {
        var dataStored: String?
        var dataLoaded: Bool?
        var dataDeleted: Bool?
        
        func storeData(_ type: String, id: String, data: Bytes) throws {
            let data = String(bytes: data, encoding: .utf8)
            dataStored = data
        }
        
        func loadData(_ type: String, id: String) throws -> Bytes {
            let data = "loaded data"
            dataLoaded = true
            return Bytes(data.utf8)
        }
        
        func deleteData(_ type: String, id: String) throws {
            dataDeleted = true
        }
    }
}
