//
//  LoginViewController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 16/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore
import CleanPlatform

class LoginViewController: BaseViewController {
    let loginPresenter: LoginPresenter
    let layout = LoginLayout()
    
    override func loadView() {
        view = layout
    }
    
    init(
        loginPresenter: LoginPresenter
    ) {
        self.loginPresenter = loginPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        layout.emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        layout.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginPresenter.viewDidLoad()
    }
    
    @objc private func loginButtonPressed() {
        loginPresenter.logIn()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField === layout.emailTextField {
            loginPresenter.updateEmail(textField.text)
        }
        
        if textField === layout.passwordTextField {
            loginPresenter.updatePassword(textField.text)
        }
    }
}

extension LoginViewController: LoginView {
    func isLoginEnabled(_ isEnabled: Bool) {
        layout.loginButton.isEnabled = isEnabled
        layout.loginButton.backgroundColor = isEnabled ? .brown : .lightGray
    }
}
