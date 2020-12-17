//
//  StringExtensionTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 16.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import XCTest
@testable import GitHub_Learning

class StringExtensionTests: XCTestCase {
    private var sut: String!
    
    func setUpTestWith(string: String) {
        sut = string
    }
    
    func test_givenNumberInString_thenStringContainsNumber() {
        // Given
        let numbers = [
            Value(value: "1", contains: true),
            Value(value: "a", contains: false),
            Value(value: "1414", contains: true),
            Value(value: ".", contains: false),
            Value(value: "123456", contains: true)
        ]
        
        numbers.forEach() {
            // Then
            XCTAssert($0.value.containsNumber == $0.contains)
        }
    }
    
    func test_givenCapitalInString_thenStringContainsCapital() {
        // Given
        let capitals = [
            Value(value: "A", contains: true),
            Value(value: "a", contains: false),
            Value(value: "aBaC", contains: true),
            Value(value: ".", contains: false),
            Value(value: "123456", contains: false)
        ]
        
        capitals.forEach() {
        // Then
            XCTAssert($0.value.containsCapital == $0.contains)
        }
    }
    
    func test_givenValidEmail_thenIsEmail() {
        // Given
        setUpTestWith(string: "test@gmail.com")
        
        // Then
        XCTAssertTrue(sut.isEmail)
    }
    
    func test_givenMissingDotInEmail_thenIsNotEmail() {
        // Given
        setUpTestWith(string: "test@gmailcom")
        
        // Then
        XCTAssertFalse(sut.isEmail)
    }
    
    func test_givenMissingAtSignInEmail_thenIsNotEmail() {
        // Given
        setUpTestWith(string: "testgmail.com")
        
        // Then
        XCTAssertFalse(sut.isEmail)
    }
    
    func test_givenInvalidDomainInEmail_thenIsNotEmail() {
        // Given
        setUpTestWith(string: "test@gmail.c")
        
        // Then
        XCTAssertFalse(sut.isEmail)
    }
    
    func test_givenMissingUsernameInEmail_thenIsNotEmail() {
        // Given
        setUpTestWith(string: "@gmail.com")
        
        // Then
        XCTAssertFalse(sut.isEmail)
    }
    
    func test_givenMissingMailServerInEmail_thenIsNotEmail() {
        // Given
        setUpTestWith(string: "test@.com")
        
        // Then
        XCTAssertFalse(sut.isEmail)
    }
    
    private struct Value {
        let value: String
        let contains: Bool
    }
}
