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
    func previous()
    func presentingPage(at index: Int)
}

final class OnboardingPresenterImpl: BasePresenter<OnboardingView>, Listener {
    
    private let onboardingController: OnboardingController
    private var index: Int = 0 {
        didSet {
            showPage()
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
    
    private func showPage() {
        let title = index < numberOfPages - 1 ? "Next" : "Log In"
        view?.setButtonTitle(title)
        if index <= numberOfPages - 1 {
            view?.showPage(at: index)
        }
    }
    
}

extension OnboardingPresenterImpl: OnboardingPresenter {
    
    func previous() {
        index -= 1
        showPage()
    }
    
    func presentingPage(at index: Int) {
        self.index = index
    }
    
    func next() {
        index += 1
        showPage()
    }
    
}
