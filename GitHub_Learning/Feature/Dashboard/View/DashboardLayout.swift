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
    
    let dashboardTableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .grouped)
        tb.register(CryptoPriceCell.self, forCellReuseIdentifier: CryptoPriceCell.identifier)
        tb.backgroundColor = .clear
        tb.rowHeight = 88
        tb.allowsSelection = false
        tb.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        return tb
    }()
    
    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "dashboard")
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(backgroundImageView)
        addSubview(dashboardTableView)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        dashboardTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
