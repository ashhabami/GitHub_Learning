//
//  StartUpController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 03.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol StartUpController: BaseController {
    func startUp()
}

final class StartUpControllerImpl: BaseControllerImpl {
    private let loadOnboardingFinishedFacade: LoadOnboardingFinishedFacade
    private let wireframe: Wireframe
    
    init(
        loadOnboardingFinishedFacade: LoadOnboardingFinishedFacade,
        wireframe: Wireframe
    ) {
        self.loadOnboardingFinishedFacade = loadOnboardingFinishedFacade
        self.wireframe = wireframe
    }
}

extension StartUpControllerImpl: StartUpController {
    func startUp() {
        loadOnboardingFinishedFacade.load(LoadOnboardingFinishedRequest()) { response in
            switch response {
            case .success(response: let response):
                response.isFinished ? self.wireframe.setLoginAsRoot() : self.wireframe.setOnboardingAsRoot()
            case .failure(error: let error):
                print(error)
            }
        }
    }
}
