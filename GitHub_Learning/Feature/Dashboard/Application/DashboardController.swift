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
    var cryptocurrencies: [Cryptocurrency] { get set }
    func loadCrypto(_ completion: (() -> Void)?)
}

final class DashboardControllerImpl: BaseControllerImpl {
    private var email: String?
    private let cryptocurrencyPricesFacade: CryptocurrencyPricesFacade
    private var timer: Timer?
    var cryptocurrencies = [Cryptocurrency]() {
        didSet {
            notifyListenersAboutUpdate()
        }
    }
    
    init(
        cryptocurrencyPricesFacade: CryptocurrencyPricesFacade
    ) {
        self.cryptocurrencyPricesFacade = cryptocurrencyPricesFacade
        super.init()
    }
    
    private func loadCryptocurrency(_ completion: (() -> Void)? = nil) {
        cryptocurrencyPricesFacade.getCryptocurrencyPrice() { result in
            self.handleResult(result) { (response) in
                self.cryptocurrencies = response.cryptocurrencies
                completion?()
            }
        }
    }
}

extension DashboardControllerImpl: DashboardController {
    func loadCrypto(_ completion: (() -> Void)? = nil) {
        timer?.invalidate()
        loadCryptocurrency(completion)
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in self.loadCryptocurrency() })
    }
    
    func getEmail() -> String? {
        return email
    }
    
    func setEmail(_ email: String) {
        self.email = email
    }
}
