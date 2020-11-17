//
//  LoginPresenter.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 16/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanPlatform
import CleanCore

protocol LoginPresenter: Presenter, Listener {
    
}

final class LoginPresenterImpl: BasePresenter<LoginView> {
    
    let loginController: LoginController
    
    init(
        loginController: LoginController
    ) {
        self.loginController = loginController
    }
    
    func viewDidLoad() {
        
    }
    
}

extension LoginPresenterImpl: LoginPresenter {
    
}
