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
    func logInWith(email: String?, password: String?)
}

final class LoginPresenterImpl: BasePresenter<LoginView> {
    private var loginBuilder: LoginBuilder
    private let alertProvider: AlertProviderController
    
    init(
        loginBuilder: LoginBuilder,
        alertProvider: AlertProviderController
    ) {
        self.loginBuilder = loginBuilder
        self.alertProvider = alertProvider
    }
    
    func viewDidLoad() {
        
    }
}

extension LoginPresenterImpl: LoginPresenter {
    func logInWith(email: String?, password: String?) {
        loginBuilder.email = email
        loginBuilder.password = password
        do {
            let _ = try loginBuilder.build()
        } catch {
            print(error)
        }
    }
}
