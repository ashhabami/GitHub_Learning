//
//  HeaderView.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 08.01.2021.
//  Copyright © 2021 Amin_Second_Test_Project. All rights reserved.
//

import UIKit
import Swinject

class HeaderView: UIView {
    
    let headerContentView: UIView = {
        let view = UIView()
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let rankTitleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Rank", for: .normal)
        button.tintColor = .lightGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.contentHorizontalAlignment = .leading
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 1
        return button
    }()
    
    let nameTitleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Name", for: .normal)
        button.tintColor = .lightGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.contentHorizontalAlignment = .leading
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 1
        return button
    }()
    
    let priceChangeTitleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("24h %", for: .normal)
        button.tintColor = .lightGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.contentHorizontalAlignment = .leading
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 1
        return button
    }()
    
    let priceTitleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Price(USD)", for: .normal)
        button.tintColor = .lightGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.contentHorizontalAlignment = .leading
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 1
        return button
    }()
    
    private lazy var headerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [rankTitleButton, nameTitleButton, priceChangeTitleButton, priceTitleButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .clear
        addSubview(headerContentView)
        headerContentView.addSubview(headerStack)
        
        headerContentView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
        }
        headerStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        }
    }
}
