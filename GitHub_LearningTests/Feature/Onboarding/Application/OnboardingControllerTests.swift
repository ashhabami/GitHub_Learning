//
//  OnboardingControllerTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 09/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import XCTest
import CleanCore
@testable import GitHub_Learning

class OnboardingControllerTests: XCTestCase {
    
    func testPagesIsEmpty_whenLoadPagesHaveNotBeenCalled() {
        // Given
        let controller = OnboardingControllerImpl()
        
        // When
        // LoadPages have not been called
        
        // Then
        XCTAssert(controller.pages.isEmpty)
    }
    
    func testPagesIsNotEmpty_whenLoadPagesHaveBeenCalled() {
        // Given
        let controller = OnboardingControllerImpl()
        
        // When
        controller.loadPages()
        
        // Then
        XCTAssertFalse(controller.pages.isEmpty)
    }
    
    func testNotifyListeners_whenPagesChanged() {
        // Given
        let controller = OnboardingControllerImpl()
        let listener = FakeListener()
        controller.subscribe(listener, errorBlock: nil) { _ in
            listener.isNotified = true
        }
        
        // When
        controller.loadPages()
        
        // Then
        XCTAssert(listener.isNotified)
    }
    
    private class FakeListener: Listener {
        var isNotified = false
    }
    
}
