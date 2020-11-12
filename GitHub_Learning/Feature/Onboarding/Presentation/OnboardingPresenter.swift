//
//  OnboardingPresenter.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 09/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore
import CleanPlatform

protocol OnboardingPresenter: Presenter {
    func next()
    func presentingPage(at index: Int)
    func selectedPage(at index: Int)
}

final class OnboardingPresenterImpl: BasePresenter<OnboardingView>, Listener {
    
    private let onboardingController: OnboardingController
    private var selectedIndex: Int = 0 {
        didSet {
            presentingIndex = selectedIndex
            showPage()
        }
    }
    private var presentingIndex: Int = 0 {
        didSet {
            updatePageControl()
            updateTitle()
        }
    }
    
    var numberOfPages: Int {
        get {
            onboardingController.pages.count
        }
    }
    
    init(
        onboardingController: OnboardingController
    ) {
        self.onboardingController = onboardingController
    }
    
    func viewDidLoad() {
        subscribeForListeners()
        onboardingController.loadPages()
        view?.setButtonTitle("Next")
    }
    
    private func subscribeForListeners() {
        onboardingController.subscribe(self, errorBlock: nil, updateBlock: { _ in self.update()})
    }
    
    private func update() {
        view?.setPages(makeViewModels())
    }
    
    private func updateTitle() {
        let title = presentingIndex < numberOfPages - 1 ? "Next" : "Log In"
        view?.setButtonTitle(title)
    }
    
    private func makeViewModels() -> [OnboardingPageViewModel] {
        let pages = onboardingController.pages
        let viewModel = pages.map {
            OnboardingPageViewModel(
                title: $0.title,
                text: $0.text,
                image: UIImage(named: $0.image)!
            )
        }
        return viewModel
    }
    
    private func updatePageControl() {
        view?.updatePageControl(at: presentingIndex)
    }
    
    private func showPage() {
        if presentingIndex <= numberOfPages - 1 {
            view?.showPage(at: presentingIndex)
        }
    }
    
}

extension OnboardingPresenterImpl: OnboardingPresenter {
    
    func selectedPage(at index: Int) {
        self.selectedIndex = index
    }
    
    func presentingPage(at index: Int) {
        self.presentingIndex = index
    }
    
    func next() {
        presentingIndex += 1
        showPage()
    }
    
}
