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
        dashboardCotroller.subscribe(self, errorBlock: nil, updateBlock: { _ in self.updateBlock()})
    }
    
    private func makeViewModelFrom(_ cryprocurrency: Cryptocurrency?) -> CryptocurrencyViewModel? {
        guard let cryprocurrencyUnwraped = cryprocurrency else { return nil }
        let url = cryprocurrencyUnwraped.imageUrl ?? ""
        let price = String(cryprocurrencyUnwraped.price ?? 0)
        var priceChangePercentage = cryprocurrencyUnwraped.priceChange?.toString() ?? "N&N"
        let symbol = cryprocurrencyUnwraped.symbol?.uppercased() ?? "N&N"
        let priceChange: PriceChangeDirection
        
        priceChangePercentage += " %"
        if priceChangePercentage.contains("-") {
            priceChange = .negative
        } else if priceChangePercentage.contains("N&N") || priceChangePercentage.contains("0.0") {
            priceChange = .neutral
            priceChangePercentage.insert(contentsOf: "+ ", at: priceChangePercentage.startIndex)
        } else {
            priceChange = .positive
            priceChangePercentage.insert(contentsOf: "+ ", at: priceChangePercentage.startIndex)
        }
        
        return CryptocurrencyViewModel(
            imageUrl: URL(string: url),
            price: price,
            priceChangePercentage: priceChangePercentage,
            priceChange: priceChange,
            symbol: symbol
        )
    }
    
    private func updateBlock() {
        guard let viewModel = makeViewModelFrom(dashboardCotroller.cryptocurrency) else { return }
        view?.setCryptocurrencyPrice(viewModel.price)
        view?.setCryptocurrencyImage(viewModel.imageUrl)
        view?.setCryptocurrencyPriceChange(viewModel.priceChangePercentage, direction: viewModel.priceChange)
        view?.setCryptocurrencySymbol("\(viewModel.symbol)/USD")
    }
}

extension DashboardPresenterImpl: DashboardPresenter {
    func logOut() {
        logOutController.logOut()
    }
}
