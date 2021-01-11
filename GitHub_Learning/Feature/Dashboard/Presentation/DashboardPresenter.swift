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
    private var lastPrices : [String?]?
    private var lastPriceChanges : [String?]?
    
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
        let name = cryprocurrency.name ?? "N&N"
        let url = cryprocurrency.imageUrl ?? ""
        var price = String((cryprocurrency.price ?? 0).rounded(toPlaces: 4))
        price.insert(contentsOf: "$", at: price.startIndex)
        let symbol = cryprocurrency.symbol?.uppercased() ?? "N&N"
        let rank = String(cryprocurrency.rank ?? 0) + "."
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
            name: name,
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
        var index = 0
        
        dashboardCotroller.cryptocurrencies.forEach {
            var viewModel = makeViewModelFrom($0)
            viewModel.lastPriceChange = lastPriceChanges?[index]
            viewModel.lastPrice = lastPrices?[index]
            cryptocurrencyViewModels.append(viewModel)
            if let lastPrices = lastPrices, let lastPriceChanges = lastPriceChanges {
                if index < lastPrices.count - 1, index < lastPriceChanges.count - 1 {
                    index += 1
                }
            }
        }
        
        lastPriceChanges = []
        lastPrices = []
        cryptocurrencyViewModels.forEach {
            lastPriceChanges?.append($0.priceChangePercentage)
            lastPrices?.append($0.price)
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
