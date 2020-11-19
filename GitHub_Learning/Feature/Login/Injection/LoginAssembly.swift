
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
        container.autoregister(LoginViewController.self, initializer: LoginViewController.init).implements(LoginView.self)
        container.autoregister(LoginPresenter.self, initializer: LoginPresenterImpl.init)
            .initCompleted { (r, presenter) in
                (presenter as? LoginPresenterImpl)?.view = r.resolve(LoginView.self)
            }
        container.autoregister(LoginBuilder.self, initializer: LoginBuilderImpl.init)
    }
}
