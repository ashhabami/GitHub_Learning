//
//  ViewController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 06/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import UIKit
import CleanCore
import CleanPlatform

class OnboardingViewController: BaseViewController {
    
    private let layout = OnboardingLayout()
    private let presenter: OnboardingPresenter

    override func loadView() {
        view = layout
    }
    
    init(
        onboardingPresenter: OnboardingPresenter
    ) {
        self.presenter = onboardingPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension OnboardingViewController: OnboardingView {
    
    func setPages(_ pages: [OnboardingPage]) {
        
    }
    
}
