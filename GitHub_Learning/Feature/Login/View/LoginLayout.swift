//
//  LoginLayout.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 16/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import UIKit
import SnapKit

class LoginLayout: UIView {
    private lazy var loginStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textFieldView, loginButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private lazy var textFieldStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailTextField, separatorLineView, passwordTextField])
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "space")
        return iv
    }()
    
    lazy var textFieldView: UIView = {
        let view = UIView()
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.addSubview(textFieldStack)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.cgColor
        return view
    }()
    
    lazy var separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.tag = 0
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 5
        let myAttribute = [NSAttributedString.Key.foregroundColor: UIColor.lightText]
        let myAttrString = NSAttributedString(string: "Enter your email", attributes: myAttribute)
        tf.textColor = .white
        tf.attributedPlaceholder = myAttrString
        tf.contentVerticalAlignment = .center
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.tag = 1
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = 5
        let myAttribute = [NSAttributedString.Key.foregroundColor: UIColor.lightText]
        let myAttrString = NSAttributedString(string: "Enter your password", attributes: myAttribute)
        tf.textColor = .white
        tf.isSecureTextEntry = true
        tf.attributedPlaceholder = myAttrString
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        addSubview(backgroundImageView)
        addSubview(loginStack)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        loginStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
            $0.top.greaterThanOrEqualToSuperview().offset(130)
        }
        
        textFieldStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        }
        
        separatorLineView.snp.makeConstraints {
            $0.height.equalTo(0.5)
        }
        
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(emailTextField)
        }
        
        loginButton.snp.makeConstraints {
            $0.height.equalTo(40)
        }
    }
}
