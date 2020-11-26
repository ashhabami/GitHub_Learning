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
        if textField.tag == 0 {
            loginPresenter.updateEmail(textField.text)
        }
        
        if textField.tag == 1 {
            loginPresenter.updatePassword(textField.text)
        }
    }
}

extension LoginViewController: LoginView {
    func isLoginEnabled(_ enabled: Bool) {
        layout.loginButton.isEnabled = enabled
        layout.loginButton.backgroundColor = enabled ? .brown : .lightGray
    }
}
