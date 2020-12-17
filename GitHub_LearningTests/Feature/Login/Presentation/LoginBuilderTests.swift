//
//  LoginBuilderTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 14.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import XCTest
@testable import GitHub_Learning

class LoginBuilderTests: XCTestCase {
    private var sut: LoginBuilderImpl!
    
    func setUpTests() {
        sut = LoginBuilderImpl()
    }
    
    func test_givenEmailIsNotFilled_whenBuild_thenMissingMandatoryDataErrorIsThrown() {
        // Given
        setUpTests()
        sut.email = nil
        sut.password = "Test124567"
        
        // When
        XCTAssertThrowsError(try sut.build()) { error in
            guard let thrownError = error as? LoginBuilderError else {
                XCTFail("Wrong type of error")
                return
            }
            // Then
            XCTAssertEqual(thrownError, LoginBuilderError.missingMandatoryData)
        }
    }
    
    func test_givenPasswordIsNotFilled_whenBuild_thenMissingMandatoryDataErrorIsThrown() {
        // Given
        setUpTests()
        sut.email = "test@gmail.com"
        sut.password = nil
        
        // When
        XCTAssertThrowsError(try sut.build()) { error in
            guard let thrownError = error as? LoginBuilderError else {
                XCTFail("Wrong type of error")
                return
            }
            // Then
            XCTAssertEqual(thrownError, LoginBuilderError.missingMandatoryData)
        }
    }
    
    func test_givenEmailIsEmpty_whenBuild_thenInvalidEmailErrorIsThrown() {
        // Given
        setUpTests()
        sut.email = ""
        sut.password = "Test124567"
        
        // When
        XCTAssertThrowsError(try sut.build()) { error in
            guard let thrownError = error as? LoginBuilderError else {
                XCTFail("Wrong type of error")
                return
            }
            // Then
            XCTAssertEqual(thrownError, LoginBuilderError.invalidEmail)
        }
    }
    
    func test_givenPasswordIsEmpty_whenBuild_thenInvalidPasswordErrorIsThrown() {
        // Given
        setUpTests()
        sut.email = "test@gmail.com"
        sut.password = ""
        
        // When
        XCTAssertThrowsError(try sut.build()) { error in
            guard let thrownError = error as? LoginBuilderError else {
                XCTFail("Wrong type of error")
                return
            }
            // Then
            XCTAssertEqual(thrownError, LoginBuilderError.invalidPassword)
        }
    }
    
    func test_givenValidCredentails_whenBuild_thenCredentailsAreValidAndBuild() throws {
        // Given
        setUpTests()
        let testEmail = "test@gmail.com"
        let testPassword = "Test124567"
        sut.email = testEmail
        sut.password = testPassword
        
        // When
        let credentails = try sut.build()
        
        // Then
        XCTAssert(testEmail == credentails.email)
        XCTAssert(testPassword == credentails.password)
    }
    
    func test_givenIncorrectEmail_whenBuild_thenEmailIsNotValid() {
        // Given
        setUpTests()
        sut.email = "test@gmail.c"
        sut.password = "Test124567"
        
        // When
        XCTAssertThrowsError(try sut.build()) { error in
            guard let thrownError = error as? LoginBuilderError else {
                XCTFail("Wrong type of error")
                return
            }
            // Then
            XCTAssertEqual(thrownError, LoginBuilderError.invalidEmail)
        }
    }
    
    func test_givenNoNumberInPassword_whenBuild_thenIsNotValidPassword() {
        // Given
        setUpTests()
        sut.email = "test@gmail.com"
        sut.password = "Abcdefghch"
        
        // When
        XCTAssertThrowsError(try sut.build()) { error in
            guard let thrownError = error as? LoginBuilderError else {
                XCTFail("Wrong type of error")
                return
            }
            // Then
            XCTAssertEqual(thrownError, LoginBuilderError.invalidPassword)
        }
    }
    
    func test_givenNoCapitalInPassword_whenBuild_thenIsNotValidPassword() {
        // Given
        setUpTests()
        sut.email = "test@gmail.com"
        sut.password = "abcfe1234"
        
        // When
        XCTAssertThrowsError(try sut.build()) { error in
            guard let thrownError = error as? LoginBuilderError else {
                XCTFail("Wrong type of error")
                return
            }
            // Then
            XCTAssertEqual(thrownError, LoginBuilderError.invalidPassword)
        }
    }
    
    func test_givenLenghtOfPasswordIsLessThenSeven_whenBuild_thenIsNotValidPassword() {
        // Given
        setUpTests()
        sut.email = "test@gmail.com"
        sut.password = "Abcf12"
        
        // When
        XCTAssertThrowsError(try sut.build()) { error in
            guard let thrownError = error as? LoginBuilderError else {
                XCTFail("Wrong type of error")
                return
            }
            // Then
            XCTAssertEqual(thrownError, LoginBuilderError.invalidPassword)
        }
    }
}
