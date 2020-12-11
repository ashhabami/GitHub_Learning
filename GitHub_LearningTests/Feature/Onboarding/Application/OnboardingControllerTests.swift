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
            listener.isNotifiedAboutUpdate = true
        }
        
        // When
        sut.loadPages()
        
        // Then
        XCTAssert(listener.isNotifiedAboutUpdate)
    }
    
    func test_givenStoreOnboardingFinishedFacade_whenFacadeCallwithError_thenNotifiesListenersAboutError() {
        //Given
        let listener = FakeListener()
        setUpTest(storeOnboardingFinishedFacade: StoreOnboardingFinishedFacadeFailureStub())
        
        //When
        sut.subscribe(listener, errorBlock: { _ in
            listener.error = self.sut.lastError
        }, updateBlock: nil)
        sut.storeOnboardingFinished(isFinished: true)
        
        //Then
        XCTAssertNotNil(listener.error)
    }
    
    func test_givenStoreOnboardingFinishedFacade_whenFacadeCallwithSuccess_thenNotNotifiesListenersAboutError() {
        //Given
        let listener = FakeListener()
        setUpTest(storeOnboardingFinishedFacade: StoreOnboardingFinishedFacadeSuccessStub())
        
        //When
        sut.subscribe(listener, errorBlock: { _ in
            listener.error = self.sut.lastError
        }, updateBlock: nil)
        sut.storeOnboardingFinished(isFinished: true)
        
        //Then
        XCTAssertNil(listener.error)
    }
    
    func test_givenLoadOnboardingFinishedFacade_whenFacadeCallwithSuccess_thenNotifiesListenersAboutUpdate() {
        //Given
        let listener = FakeListener()
        setUpTest(loadOnboardingFinishedFacade: LoadOnboardingFinishedFacadeSuccessStub())
        
        //When
        sut.subscribe(listener, errorBlock: nil, updateBlock: { _ in
            listener.isNotifiedAboutUpdate = true
        })
        sut.getOnboardingFinished(completion: { _ in })
        
        //Then
        XCTAssertTrue(listener.isNotifiedAboutUpdate)
    }
    
    func test_givenLoadOnboardingFinishedFacade_whenFacadeCallwithError_thenNotifiesListenersAboutError() {
        //Given
        let listener = FakeListener()
        setUpTest(loadOnboardingFinishedFacade: LoadOnboardingFinishedFacadeFailureStub())
        
        //When
        sut.subscribe(listener, errorBlock: { _ in
            listener.error = self.sut.lastError
        }, updateBlock: nil)
        sut.getOnboardingFinished(completion: { _ in })
        
        //Then
        XCTAssertNotNil(listener.error)
    }
    
    private class FakeListener: Listener {
        var isNotifiedAboutUpdate = false
        var error: Error?
    }
    
    private class LoadOnboardingFinishedFacadeDummy: LoadOnboardingFinishedFacade {
        func load(_ request: LoadOnboardingFinishedRequest, completion: @escaping ((Result<LoadOnboardingFinishedResponse>) -> Void)) {}
    }
    
    private class LoadOnboardingFinishedFacadeSuccessStub: LoadOnboardingFinishedFacade {
        func load(_ request: LoadOnboardingFinishedRequest, completion: @escaping ((Result<LoadOnboardingFinishedResponse>) -> Void)) {
            completion(.success(response: LoadOnboardingFinishedResponse(isFinished: true)))
        }
    }
    
    private class LoadOnboardingFinishedFacadeFailureStub: LoadOnboardingFinishedFacade {
        func load(_ request: LoadOnboardingFinishedRequest, completion: @escaping ((Result<LoadOnboardingFinishedResponse>) -> Void)) {
            completion(.failure(error: LocalStorageError.loadFailed("Load Failed")))
        }
    }
    
    private class StoreOnboardingFinishedFacadeDummy: StoreOnboardingFinishedFacade {
        func store(_ request: StoreOnboardingFinishedRequest, _ completion: @escaping ((Result<StoreOnboardingFinishedResponse>) -> Void)) {}
    }

    private class StoreOnboardingFinishedFacadeFailureStub: StoreOnboardingFinishedFacade {
        func store(_ request: StoreOnboardingFinishedRequest, _ completion: @escaping ((Result<StoreOnboardingFinishedResponse>) -> Void)) {
            completion(.failure(error: LocalStorageError.storeFailed("Store Failed")))
        }
    }

    private class StoreOnboardingFinishedFacadeSuccessStub: StoreOnboardingFinishedFacade {
        func store(_ request: StoreOnboardingFinishedRequest, _ completion: @escaping ((Result<StoreOnboardingFinishedResponse>) -> Void)) {
            completion(.success(response: StoreOnboardingFinishedResponse()))
        }
    }
}
