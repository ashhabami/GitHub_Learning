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
    func updatePageControlFor(_ page: Int)
    func updatePageTo(_ page: Int)
    func updateButtonTitleFor(_ page: Int)
}

final class OnboardingPresenterImpl: BasePresenter<OnboardingView>, Listener {
    
    private let onboardingController: OnboardingController
    
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
    
    private func subscribeForListeners() {
        onboardingController.subscribe(self, errorBlock: nil, updateBlock: { _ in self.update()})
    }
    
    private func update() {
        view?.setPages(makeViewModels())
        view?.setNumberOfPagesControls(onboardingController.pages.count)
    }
    
    func viewDidLoad() {
        subscribeForListeners()
        onboardingController.loadPages()
    }
    
    private func makeViewModels() -> [OnboardingPageViewModel] {
        let pages = onboardingController.pages
        let viewModel = pages.map {
            OnboardingPageViewModel(onboardingPage: $0)
        }
        return viewModel
    }
    
}

extension OnboardingPresenterImpl: OnboardingPresenter {
    
    func updateButtonTitleFor(_ page: Int) {
        let title = page < numberOfPages - 1 ? "Next" : "Log In"
        view?.setButtonTitle(title)
    }
    
    func updatePageTo(_ page: Int) {
        if page <= numberOfPages - 1 {
            view?.setPageTo(page)
        }
    }
    
    func updatePageControlFor(_ page: Int) {
        view?.setSelectedPageControlFor(page)
    }
    
}
