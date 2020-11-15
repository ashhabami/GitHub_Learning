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
    var sut: OnboardingPresenter!
    private var view: OnboardingView!
    private var controller: OnboardingController!
    private var launchController: LoginLauncherController!
    
    private func setUpWith(onboardingController: OnboardingController? = nil, onboardingLauncher: LoginLauncherController? = nil, onboardingView: OnboardingView? = nil) {
        self.controller = onboardingController != nil ? onboardingController! : FakeOnboardingController()
        self.launchController = onboardingLauncher != nil ? onboardingLauncher! : FakeLoginLauncherController()
        self.view = onboardingView != nil ? onboardingView! : FakeView()
        
        let presenter = OnboardingPresenterImpl(onboardingController: controller, loginLauncherController: launchController)
        presenter.view = view
        sut = presenter
    }
    
    func testIncresePage_whenNextNotOnLastPage() {
        // Given
        let view = FakeView()
        let launcher = FakeLoginLauncherController()
        setUpWith(onboardingLauncher: launcher, onboardingView: view)
        
        // When
        sut.viewDidLoad()
        var nextPage = 0
        view.presentingIndex = 0
        for _ in 0..<view.pages.count - 1 {
            nextPage = view.presentingIndex! + 1
            sut.next()
        }
        
        // Then
        XCTAssertTrue(view.presentingIndex == nextPage)
        XCTAssertNil(launcher.isLaunched)
    }
    
    func testLaunchLogin_whenNextOnLastPage() {
        // Given
        let launcher = FakeLoginLauncherController()
        let view = FakeView()
        setUpWith(onboardingLauncher: launcher, onboardingView: view)
        
        // When
        sut.viewDidLoad()
        for _ in 0...view.pages.count - 1 {
            sut.next()
        }
        
        // Then
        XCTAssertNotNil(launcher.isLaunched)
    }
    
    func testViewUpdate_whenSelectedPage() {
        // Given
        let view = FakeView()
        setUpWith(onboardingView: view)
        
        // When
        sut.viewDidLoad()
        let index = Int.random(in: 0...view.pages.count - 1)
        sut.selectedPage(at: index)
        
        
        // Then
        XCTAssertNotNil(view.presentingIndex)
    }
    
    func testButtonTitleUpdate_whenSelectedPageIsLastPage() {
        // Given
        let view = FakeView()
        setUpWith(onboardingView: view)
        
        // When
        sut.viewDidLoad()
        sut.selectedPage(at: view.pages.count - 1)
        
        
        // Then
        XCTAssertTrue(view.buttonTitle == "Log In")
    }
    
    func testButtonTitleUpdate_whenSelectedPageIsNotLastPage() {
        // Given
        let view = FakeView()
        setUpWith(onboardingView: view)
        
        // When
        sut.viewDidLoad()
        let index = Int.random(in: 0..<view.pages.count - 1)
        sut.selectedPage(at: index)
        
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
        let view = FakeView()
        setUpWith(onboardingView: view)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertNotNil(view.buttonTitle)
    }
    
    private class FakeView: OnboardingView {
        var pages: [OnboardingPageViewModel] = []
        var presentingIndex: Int?
        var buttonTitle: String?
        
        func setPages(_ pages: [OnboardingPageViewModel]) {
            self.pages = pages
        }
        
        func showPage(at index: Int) {
            presentingIndex = index
        }
        
        func setButtonTitle(_ title: String) {
            buttonTitle = title
        }
        
        func startLoading() {}
        
        func stopLoading() {}
    }
    
    private class FakeOnboardingController: BaseControllerImpl, OnboardingController {
        var isPagesLoaded: Bool?
        var isSubscribed: Bool?
        
        override func subscribe(_ listener: Listener, errorBlock: ErrorBlock?, updateBlock: UpdateBlock?) {
            super.subscribe(listener, errorBlock: errorBlock, updateBlock: updateBlock)
            isSubscribed = true
        }
        
        var pages: [OnboardingPage] = [] {
            didSet {
                notifyListenersAboutUpdate()
            }
        }
        
        func loadPages() {
            var pagesToLoad = [OnboardingPage]()
            for _ in 1...Int.random(in: 1...10) {
                pagesToLoad.append(
                    OnboardingPage(
                        title: "fake",
                        text: "fake",
                        image: "onboarding1"
                    )
                )
            }
            pages = pagesToLoad
            isPagesLoaded = true
        }
    }
    
    private class FakeLoginLauncherController: BaseControllerImpl, LoginLauncherController {
        var isLaunched: Bool?
        
        func launchLogin() {
            isLaunched = true
        }
    }
}
