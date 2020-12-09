//
//  DashboardController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 27.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol DashboardController: BaseController {
    func setEmail(_ email: String)
    func getEmail() -> String?
}

final class DashboardControllerImpl: BaseControllerImpl {
    private var email: String?    
}

extension DashboardControllerImpl: DashboardController {
    func getEmail() -> String? {
        return email
    }
    
    func setEmail(_ email: String) {
        self.email = email
    }
}
