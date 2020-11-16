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
    
    func testButtonTitleUpdate_whenSelectedPageIsLastPage() {
        // Given
        let controller = FakeOnboardingController()
        let view = FakeOnboardingView()
        setUpWith(onboardingController: controller, onboardingView: view)
        
        // When
        sut.selectedPage(at: controller.lastPageIndex)
        
        // Then
        XCTAssertTrue(view.buttonTitle == "Log In")
    }
    
    func testButtonTitleUpdate_whenSelectedPageIsNotLastPage() {
        // Given
        let controller = FakeOnboardingController()
        let view = FakeOnboardingView()
        setUpWith(onboardingController: controller, onboardingView: view)
        
        // When
        sut.selectedPage(at: controller.lastPageIndex - 1)
        
        // Then
        XCTAssertTrue(view.buttonTitle == "Next")
    }
    
    func testSubscribeForPages_whenViewDidLoad() {
        // Given
        let controller = FakeOnboardingController()
        setUpWith(onboardingController: controller)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertNotNil(controller.isSubscribed)
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
    
    private class FakeOnboardingView: FakeView, OnboardingView {
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
    
    private class FakeOnboardingController: FakeBaseController, OnboardingController {
        var isPagesLoaded: Bool?
        
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
    }
    
    private class FakeLoginLauncherController: FakeBaseController, LoginLauncherController {
        var isLaunched: Bool?
        
        func launchLogin() {
            isLaunched = true
        }
    }
}