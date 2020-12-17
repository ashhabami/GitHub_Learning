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
            Value(value: "123456", contains: true),
            Value(value: "a 1", contains: true),
            Value(value: "a4fC", contains: true),
            Value(value: "1.3", contains: true),
            Value(value: "1,3", contains: true),
            Value(value: "3_2", contains: true)
        ]
        
        // Then
        numbers.forEach() {
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
            Value(value: "123456", contains: false),
            Value(value: "1 A 6 89", contains: true),
            Value(value: "145.@sdfj", contains: false),
            Value(value: "69,0123_123.213A803", contains: true),
            Value(value: " ._§ěšč.1AF!", contains: true),
            Value(value: "`@@#$~ ^&*{°} {*&^<>–;' [][≤", contains: false)
        ]
        
        // Then
        capitals.forEach() {
            XCTAssert($0.value.containsCapital == $0.contains)
        }
    }
    
    func test_givenInvalidEmail_thenIsNotEmail() {
        // Given
        let emails = [
          Email(email: "test@gmailcom", isEmail: false),
          Email(email: "testgmail.com", isEmail: false),
          Email(email: "test@gmail.c", isEmail: false),
          Email(email: "@gmail.com", isEmail: false),
          Email(email: "test@.com", isEmail: false),
          Email(email: "test@gmail.com", isEmail: true),
          Email(email: "aminsdfsdfkj12ě@seznam.cze", isEmail: true)
        ]
        
        // Then
        emails.forEach() {
            XCTAssert($0.email.isEmail == $0.isEmail)
        }
    }
    
    private struct Value {
        let value: String
        let contains: Bool
    }
    
    private struct Email {
        let email: String
        let isEmail: Bool
    }
}
