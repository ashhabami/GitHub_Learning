
//
//  File.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 16/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import Swinject

class LoginAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(LoginViewController.self, initializer: LoginViewController.init)
        container.autoregister(LoginPresenter.self, initializer: LoginPresenterImpl.init)
        container.autoregister(LoginController.self, initializer: LoginControllerImpl.init)
    }
}
