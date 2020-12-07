//
//  DashboardLayout.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 27.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import UIKit
import SnapKit

class DashboardLayout: UIView {
    private lazy var dashboardStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dashboardLabel, logoutButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LogOut", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)
        button.backgroundColor = .brown
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    let dashboardLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemYellow
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(dashboardStack)
        dashboardStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
            $0.bottom.equalTo(self.snp.centerY)
        }
        dashboardLabel.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(100)
        }
        logoutButton.snp.makeConstraints {
            $0.height.equalTo(40)
        }
    }
}
