//
//  DashboardPresenter.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 27.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol DashboardPresenter: Presenter, Listener {
    func logOut()
    func refresh(_ completion: (() -> Void)?)
}

final class DashboardPresenterImpl: BasePresenter<DashboardView> {
    private let logOutController: LogOutController
    private let dashboardCotroller: DashboardController
    
    init(
        dashboardCotroller: DashboardController,
        logOutController: LogOutController
    ) {
        self.dashboardCotroller = dashboardCotroller
        self.logOutController = logOutController
    }
    
    func viewDidLoad() {
        view?.setEmail(dashboardCotroller.getEmail())
        dashboardCotroller.subscribe(self, errorBlock: nil, updateBlock: { _ in self.updateBlock() })
        dashboardCotroller.loadCrypto(nil)
    }
    
    private func makeViewModelFrom(_ cryprocurrency: Cryptocurrency) -> CryptocurrencyViewModel {
        let url = cryprocurrency.imageUrl ?? ""
        let price = String((cryprocurrency.price ?? 0).rounded(toPlaces: 4))
        let symbol = cryprocurrency.symbol?.uppercased() ?? "N&N"
        let rank = String(cryprocurrency.rank ?? 0)
        let priceChange: PriceChangeDirection
        var priceChangePercentage: String
        
        if let change = cryprocurrency.priceChange {
            priceChangePercentage = change.toString() + " %"
            if change > 0 {
                priceChange = .positive
                priceChangePercentage.insert(contentsOf: "+", at: priceChangePercentage.startIndex)
            } else {
                priceChange = .negative
            }
        } else {
            priceChange = .neutral
            priceChangePercentage = "N&N"
        }
        
        return CryptocurrencyViewModel(
            imageUrl: URL(string: url),
            price: price,
            priceChangePercentage: priceChangePercentage,
            priceChange: priceChange,
            symbol: symbol,
            rank: rank
        )
    }
    
    private func updateBlock() {
        var cryptocurrencyViewModels = [CryptocurrencyViewModel]()
        dashboardCotroller.cryptocurrencies.forEach {
            let viewModel = makeViewModelFrom($0)
            cryptocurrencyViewModels.append(viewModel)
        }
        view?.setCryptocurrency(cryptocurrencyViewModels)
    }
}

extension DashboardPresenterImpl: DashboardPresenter {
    func refresh(_ completion: (() -> Void)? = nil) {
        dashboardCotroller.loadCrypto(completion)
    }
    
    func logOut() {
        logOutController.logOut()
    }
}
