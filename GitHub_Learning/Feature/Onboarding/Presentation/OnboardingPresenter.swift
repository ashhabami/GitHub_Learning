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
    
}

final class OnboardingPresenterImpl: BasePresenter<OnboardingView>, Listener {
    
    private let onboardingController: OnboardingController
    
    init(
        onboardingController: OnboardingController
    ) {
        self.onboardingController = onboardingController
    }
    
    private func subscribeForListeners() {
        onboardingController.subscribe(self, errorBlock: nil, updateBlock: {_ in self.update()})
    }
    
    private func update() {
        
    }
    
    func viewDidLoad() {
        onboardingController.loadPages()
        view?.setPages(onboardingController.pages)
    }
    
}

extension OnboardingPresenterImpl: OnboardingPresenter {

}
