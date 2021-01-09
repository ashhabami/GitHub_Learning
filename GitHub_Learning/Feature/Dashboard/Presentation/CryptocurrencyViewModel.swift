//
//  DashboardViewModel.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 22.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation

enum PriceChangeDirection {
    case positive
    case negative
    case neutral
}

struct CryptocurrencyViewModel {
    let imageUrl: URL?
    let price: String
    let priceChangePercentage: String
    let priceChange: PriceChangeDirection
    let symbol: String
    let rank: String
}
