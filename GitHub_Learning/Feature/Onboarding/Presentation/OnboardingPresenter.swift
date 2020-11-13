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
    func selectedPage(at index: Int)
}

final class OnboardingPresenterImpl: BasePresenter<OnboardingView>, Listener {
    
    private let onboardingController: OnboardingController
    private var index: Int = 0 {
        didSet {
            updateTitle()
            showPage()
        }
    }
    
    private var lastIndex: Int {
        get {
            onboardingController.pages.count - 1
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
        let title = index < lastIndex ? "Next" : "Log In"
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
    
    private func showPage() {
        view?.showPage(at: index)
    }
    
}

extension OnboardingPresenterImpl: OnboardingPresenter {
    
    func selectedPage(at index: Int) {
        self.index = index
    }
    
    func next() {
        if index < lastIndex {
            index += 1
        } else {
            // Log In: TODO
        }
    }
    
}
