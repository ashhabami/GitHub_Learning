//
//  DashboardController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 27.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol DashboardController: BaseController {
    func setEmail(_ email: String)
    func getEmail() -> String?
    var cryptocurrency: Cryptocurrency? { get set }
}

final class DashboardControllerImpl: BaseControllerImpl {
    private var email: String?
    private let cryptocurrencyPriceFacade: CryptocurrencyPriceFacade
    var cryptocurrency: Cryptocurrency? {
        didSet {
            notifyListenersAboutUpdate()
        }
    }
    
    init(
        cryptocurrencyPriceFacade: CryptocurrencyPriceFacade
    ) {
        self.cryptocurrencyPriceFacade = cryptocurrencyPriceFacade
        super.init()
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: {_ in self.loadCryptocurrency()})
        loadCryptocurrency()
    }
    
    private func loadCryptocurrency() {
        cryptocurrencyPriceFacade.getCryptocurrencyPrice() { result in
            self.handleResult(result) { (response) in
                self.cryptocurrency = response.cryptocurrency
            }
        }
    }
}

extension DashboardControllerImpl: DashboardController {
    func getEmail() -> String? {
        return email
    }
    
    func setEmail(_ email: String) {
        self.email = email
    }
}
