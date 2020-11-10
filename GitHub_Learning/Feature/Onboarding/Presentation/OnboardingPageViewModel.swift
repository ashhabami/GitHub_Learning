//
//  OnboardingPageViewModel.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 10/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import UIKit

struct OnboardingPageViewModel {
    let title: String
    let text: String
    let image: UIImage
    
    init(onboardingPage: OnboardingPage) {
        self.title = onboardingPage.title
        self.text = onboardingPage.text
        self.image = UIImage(named: onboardingPage.image)!
    }
}
