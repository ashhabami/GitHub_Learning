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
        let stack = UIStackView(arrangedSubviews: [cryptocurrencyPriceStack, spacer])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private lazy var cryptocurrencyPriceStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cryptocurrencyLogoImageView, cryptocurrencyPriceChangePercentageLabel, cryptocurrencyPriceLabel, cryptocurrencySymbolLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    let cryptocurrencyLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        return imageView
    }()
    
    let cryptocurrencyPriceChangePercentageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        return label
    }()
    
    let cryptocurrencyPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        return label
    }()
    
    let cryptocurrencySymbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        return label
    }()
    
    let spacer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
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
            $0.edges.equalTo(safeAreaLayoutGuide).inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
        spacer.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(1)
        }
        cryptocurrencyLogoImageView.snp.makeConstraints {
            $0.width.equalTo(cryptocurrencyLogoImageView.snp.height)
        }
        cryptocurrencyPriceLabel.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
}
