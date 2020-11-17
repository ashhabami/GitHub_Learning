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
    let loginLayout = LoginLayout()
    
    override func loadView() {
        view = loginLayout
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
        loginPresenter.viewDidLoad()
    }
}
