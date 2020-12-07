//
//  OnboardingPresenterTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 13/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import XCTest
import CleanCore
@testable import GitHub_Learning

class OnboardingPresenterTests: XCTestCase {
    private var sut: OnboardingPresenterImpl!
    private var view: OnboardingView!
    private var controller: OnboardingController!
    private var launchController: LoginLauncherController!
    
    private func setUpWith(
        onboardingController: OnboardingController? = nil,
        onboardingLauncher: LoginLauncherController? = nil,
        onboardingView: OnboardingView? = nil
    ) {
        self.controller = onboardingController ?? FakeOnboardingController()
        self.launchController = onboardingLauncher ?? FakeLoginLauncherController()
        self.view = onboardingView ?? FakeOnboardingView()
        
        let presenter = OnboardingPresenterImpl(onboardingController: controller, loginLauncherController: launchController)
        presenter.view = view
        sut = presenter
    }
    
    func testIncresePage_whenNextNotOnLastPage() {
        // Given
        let controller = FakeOnboardingController()
        let view = FakeOnboardingView()
        let launcher = FakeLoginLauncherController()
        setUpWith(onboardingController: controller, onboardingLauncher: launcher, onboardingView: view)
        
        // When
        let index = 0
        sut.index = index
        sut.next()
            
        // Then
        XCTAssertTrue(view.isPageShown)
        XCTAssertEqual(view.presentingIndex, index + 1)
        XCTAssertNil(launcher.isLaunched)
    }
    
    func testLaunchLogin_whenNextOnLastPage() {
        // Given
        let controller = FakeOnboardingController()
        let launcher = FakeLoginLauncherController()
        let view = FakeOnboardingView()
        setUpWith(onboardingController: controller, onboardingLauncher: launcher, onboardingView: view)
        
        // When
        let index = controller.lastPageIndex
        sut.index = index
        sut.next()
        
        // Then
        XCTAssertNotNil(launcher.isLaunched)
    }
    
    func testViewUpdate_whenSelectedPage() {
        // Given
        let view = FakeOnboardingView()
        setUpWith(onboardingView: view)
        let index = 2

        // When
        sut.selectedPage(at: index)
        
        // Then
        XCTAssertEqual(view.presentingIndex, index)
    }
    
    func testButtonTitleUpdate_whenPageIsLastPage() {
        // Given
        let controller = FakeOnboardingController()
        let view = FakeOnboardingView()
        setUpWith(onboardingController: controller, onboardingView: view)
        
        // When
        sut.index = controller.lastPageIndex
        
        // Then
        XCTAssertEqual(view.buttonTitle, "Log In")
    }
    
    func testButtonTitleUpdate_whenPageIsNotLastPage() {
        // Given
        let controller = FakeOnboardingController()
        let view = FakeOnboardingView()
        setUpWith(onboardingController: controller, onboardingView: view)
        
        // When
        sut.index = controller.lastPageIndex - 1
        
        // Then
        XCTAssertEqual(view.buttonTitle, "Next")
    }
    
    func testUpdateIndex_whenSelectedPage() {
        // Given
        let controller = FakeOnboardingController()
        let view = FakeOnboardingView()
        setUpWith(onboardingController: controller, onboardingView: view)
        
        // When
        let index = 1
        sut.selectedPage(at: index)
        
        // Then
        XCTAssertEqual(sut.index, index)
    }
    
    func testSubscribeForPages_whenViewDidLoad() {
        // Given
        let controller = FakeOnboardingController()
        setUpWith(onboardingController: controller)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertNotNil(controller.listener)
    }
    
    func testLoadPages_whenViewDidLoad() {
        // Given
        let controller = FakeOnboardingController()
        setUpWith(onboardingController: controller)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertNotNil(controller.isPagesLoaded)
    }
    
    func testButtonTitleUpdate_whenViewDidLoad() {
        // Given
        let view = FakeOnboardingView()
        setUpWith(onboardingView: view)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertNotNil(view.buttonTitle)
    }
    
    func test_givenOnLastPage_whenNext_thenStoreOnboardingFinishedIsCalled() {
        // Given
        let controller = FakeOnboardingController()
        setUpWith(onboardingController: controller)
        
        // When
        sut.index = controller.lastPageIndex
        sut.next()
        
        // Then
        XCTAssertNotNil(controller.isOnboardingFinished)
    }
    
    private class FakeOnboardingView: TestView, OnboardingView {
        var buttonTitle: String?
        var arePagesSet = false
        var isPageShown = false
        var presentingIndex: Int?
        
        func setPages(_ pages: [OnboardingPageViewModel]) {
            arePagesSet = true
        }
        
        func showPage(at index: Int) {
            presentingIndex = index
            isPageShown = true
        }
        
        func setButtonTitle(_ title: String) {
            buttonTitle = title
        }
    }
    
    private class FakeOnboardingController: TestController, OnboardingController {
        var isPagesLoaded: Bool?
        var isOnboardingFinished: Bool?
        
        var lastPageIndex: Int {
            return pages.count - 1
        }
        
        var pages: [OnboardingPage] = {
            return (0..<10).map { _ in
                OnboardingPage(
                    title: "fake",
                    text: "fake",
                    image: "onboarding1"
                )
            }
        }()
        
        func loadPages() {
            isPagesLoaded = true
        }
        
        func storeOnboardingFinished(isFinished: Bool) {
            isOnboardingFinished = isFinished
        }
        
        func getOnboardingFinished(completion: @escaping ((Bool) -> Void)) {
            
        }
    }
    
    private class FakeLoginLauncherController: TestController, LoginLauncherController {
        var isLaunched: Bool?
        
        func launchLogin() {
            isLaunched = true
        }
    }
}
