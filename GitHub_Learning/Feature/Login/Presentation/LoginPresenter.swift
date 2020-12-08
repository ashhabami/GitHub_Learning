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
    func updateEmail(_ email: String?)
    func updatePassword(_ password: String?)
    func logIn()
}

final class LoginPresenterImpl: BasePresenter<LoginView> {
    private let loginBuilder: LoginBuilder
    private let alertProvider: AlertProviderController
    private let loginController: LoginController
    
    init(
        loginBuilder: LoginBuilder,
        alertProvider: AlertProviderController,
        loginController: LoginController
    ) {
        self.loginBuilder = loginBuilder
        self.alertProvider = alertProvider
        self.loginController = loginController
    }
    
    func viewDidLoad() {
        view?.isLoginEnabled(loginBuilder.isMandatoryDataFilled)
    }
}

extension LoginPresenterImpl: LoginPresenter {
    func updateEmail(_ email: String?) {
        loginBuilder.email = email
        view?.isLoginEnabled(loginBuilder.isMandatoryDataFilled)
    }
    
    func updatePassword(_ password: String?) {
        loginBuilder.password = password
        view?.isLoginEnabled(loginBuilder.isMandatoryDataFilled)
    }
    
    func logIn() {
        do {
            let builder = try loginBuilder.build()
            loginController.logInWith(builder.email)
        } catch LoginBuilderError.missingMandatoryData {
            
        } catch LoginBuilderError.invalidEmail {
            alertProvider.showAlertWith(
                "Invalid Email",
                message: "Please re-type your email address",
                actions: [AlertAction(title: "ok", style: .`default`, completion: nil)]
            )
        } catch LoginBuilderError.invalidPassword {
            alertProvider.showAlertWith(
                "Invalid Password",
                message: "Password has to be at least 8 letter long, have at least one digit and capital letter",
                actions: [AlertAction(title: "ok", style: .`default`, completion: nil)]
            )
        } catch {}
    }
}
