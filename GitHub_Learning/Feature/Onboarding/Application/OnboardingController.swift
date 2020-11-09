//
//  PageController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 06/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore
import CleanPlatform

protocol OnboardingController: BaseController {
    var pages : [OnboardingPage] { get set }
    func loadPages()
}

class OnboardingControllerImpl: BaseControllerImpl {
    var pages: [OnboardingPage] = [] {
        didSet {
            notifyListenersAboutUpdate()
        }
    }
    
    func loadPages() {
        let pages = [
            OnboardingPage(
                text: "Welcome to initial page. Thank you for downloading our app. This app is made for eduacational purposes. Make sure to hit that like button and leave a comment in the app store.",
                image: "TODO"
            ),
            OnboardingPage(
                text: "Please let me guide you throught my jorney of becoming the best iOS developer in whole world. Here are some of the examples of my work i've done during my learning-way.",
                image: "TODO"
            ),
            OnboardingPage(
                text: "First section of my humble app is a onboarding. I'm doing this for the time, so don't be mad at me. Anyways, this is gonne be the best expirience ever",
                image: "TODO"
            ),
            OnboardingPage(
                text: "Fuck it. Just needed to fill some text into the description titiles. Yep.",
                image: "TODO"
            ),
        ]
        self.pages = pages
    }
}

extension OnboardingControllerImpl : OnboardingController {
    
}
