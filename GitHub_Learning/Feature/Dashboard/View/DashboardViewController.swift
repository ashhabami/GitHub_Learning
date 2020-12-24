//
//  DashboardViewController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 27.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import UIKit
import CleanPlatform
import SDWebImage

class DashboardViewController: BaseViewController {
    
    private let layout = DashboardLayout()
    private let presenter: DashboardPresenter
    
    override func loadView() {
        view = layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.logoutButton.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        presenter.viewDidLoad()
    }
    
    init(
        presenter: DashboardPresenter
    ) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func logoutPressed() {
        presenter.logOut()
    }
}

extension DashboardViewController: DashboardView {
    func setCryptocurrencyPrice(_ price: String) {
        layout.cryptocurrencyPriceLabel.text = price
    }
    
    func setCryptocurrencyPriceChange(_ change: String?, direction: PriceChangeDirection) {
        layout.cryptocurrencyPriceChangePercentage.text = change
        switch direction {
        case .negative: layout.cryptocurrencyPriceChangePercentage.textColor = .systemRed
        case .positive: layout.cryptocurrencyPriceChangePercentage.textColor = .systemGreen
        case .neutral:  layout.cryptocurrencyPriceChangePercentage.textColor = .black
        }
    }
    
    func setCryptocurrencyImage(_ image: URL?) {
        layout.cryptocurrencyLogoImageView.sd_setImage(with: image)
    }
    
    func setCryptocurrencySymbol(_ symbol: String) {
        layout.cryptocurrencySymbolLabel.text = symbol
    }
    
    func setEmail(_ email: String?) {
        layout.dashboardLabel.text = "Welcome to the dashboard \(email ?? "unknown user")!"
    }
}
