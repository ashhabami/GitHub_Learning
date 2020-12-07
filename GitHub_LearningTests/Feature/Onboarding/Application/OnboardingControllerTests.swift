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
    private var sut: OnboardingControllerImpl!
    private var storeFacade: StoreOnboardingFinishedFacade!
    private var loadFacade: LoadOnboardingFinishedFacade!
    
    private func setUpTest(
        storeOnboardingFinishedFacade: StoreOnboardingFinishedFacade? = nil,
        loadOnboardingFinishedFacade: LoadOnboardingFinishedFacade? = nil
    ) {
        self.storeFacade = storeOnboardingFinishedFacade ?? StoreOnboardingFinishedFacadeDummy()
        self.loadFacade = loadOnboardingFinishedFacade ?? LoadOnboardingFinishedFacadeDummy()
        sut = OnboardingControllerImpl(storeOnboardingFinishedFacade: storeFacade, loadOnboardingFinishedFacade: loadFacade)
    }
    
    func testPagesIsEmpty_whenLoadPagesHaveNotBeenCalled() {
        // Given
        setUpTest()
        
        // When
        // LoadPages have not been called
        
        // Then
        XCTAssert(sut.pages.isEmpty)
    }
    
    func testPagesIsNotEmpty_whenLoadPagesHaveBeenCalled() {
        // Given
        setUpTest()
        
        // When
        sut.loadPages()
        
        // Then
        XCTAssertFalse(sut.pages.isEmpty)
    }
    
    func testNotifyListeners_whenPagesChanged() {
        // Given
        setUpTest()
        let listener = FakeListener()
        sut.subscribe(listener, errorBlock: nil) { _ in
            listener.isNotified = true
        }
        
        // When
        sut.loadPages()
        
        // Then
        XCTAssert(listener.isNotified)
    }
    
    private class FakeListener: Listener {
        var isNotified = false
    }
    
    private class StoreOnboardingFinishedFacadeDummy: StoreOnboardingFinishedFacade {
        func store(_ request: StoreOnboardingFinishedRequest, _ completion: @escaping ((Result<StoreOnboardingFinishedResponse>) -> Void)) {
            
        }
    }

    private class LoadOnboardingFinishedFacadeDummy: LoadOnboardingFinishedFacade {
        func load(_ request: LoadOnboardingFinishedRequest, completion: @escaping ((Result<LoadOnboardingFinishedResponse>) -> Void)) {}
    }
}
