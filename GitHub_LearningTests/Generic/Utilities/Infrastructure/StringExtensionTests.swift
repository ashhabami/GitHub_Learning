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
        setUpTestWith(string: "1")
        
        // Then
        XCTAssertTrue(sut.containsNumber)
    }
    
    func test_givenNoNumberInString_thenStringDoNotContainsNumber() {
        // Given
        setUpTestWith(string: "a")
        
        // Then
        XCTAssertFalse(sut.containsNumber)
    }
    
    func test_givenCapitalInString_thenStringContainsCapital() {
        // Given
        setUpTestWith(string: "A")
        
        // Then
        XCTAssertTrue(sut.containsCapital)
    }
    
    func test_givenNoCapitalInString_thenStringDoNotContainsCapital() {
        // Given
        setUpTestWith(string: "a")
        
        // Then
        XCTAssertFalse(sut.containsCapital)
    }
    
    func test_givenTwoLettersInString_thenStringsLenghtIsTwo() {
        // Given
        setUpTestWith(string: "ab")
        
        // Then
        XCTAssertTrue(sut.length == 2)
    }
    
    func test_givenOneLettersInString_thenStringsLenghtIsNotTwo() {
        // Given
        setUpTestWith(string: "a")
        
        // Then
        XCTAssertFalse(sut.length == 2)
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
    
    func test_givenValidPassword_thenIsValidPassword() {
        // Given
        setUpTestWith(string: "Abcfe1234")
        
        // Then
        XCTAssertTrue(isValidPassword)
    }
    
    func test_givenNoNumberInPassword_thenIsNotValidPassword() {
        // Given
        setUpTestWith(string: "Abcdefghch")
        
        // Then
        XCTAssertFalse(isValidPassword)
    }
    
    func test_givenNoCapitalInPassword_thenIsNotValidPassword() {
        // Given
        setUpTestWith(string: "abcfe1234")
        
        // Then
        XCTAssertFalse(isValidPassword)
    }
    
    func test_givenLenghtOfPasswordIsLessThenSeven_thenIsNotValidPassword() {
        // Given
        setUpTestWith(string: "Abcf12")
        
        // Then
        XCTAssertFalse(isValidPassword)
    }
    
    private var isValidPassword: Bool {
        guard let sut = sut else {
            return false
        }
        guard sut.containsNumber, sut.containsCapital, sut.length > 7 else { return false }
        return true
    }
}
